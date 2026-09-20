##############################################################
#Array
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Size of array
#   4 Bytes - Size of elements
##############################################################

##############################################################
#Linked List
##############################################################
#   4 Bytes - Address of the First Node
#   4 Bytes - Size of linked list
##############################################################

##############################################################
#Linked List Node
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Address of the Next Node
##############################################################

##############################################################
#Recipe
##############################################################
#   4 Bytes - Name (address of the name)
#	4 Bytes - Ingredients (address of the ingredients array)
#   4 Bytes - Cooking Time
#	4 Bytes - Difficulty
#	4 Bytes - Rating
##############################################################


.data
space: .asciiz " "
newLine: .asciiz "\n"
tab: .asciiz "\t"
lines: .asciiz "------------------------------------------------------------------\n"

listStr: .asciiz "List: \n"
recipeName: .asciiz "Recipe name: "
ingredients: .asciiz "Ingredients: "
cookingTime: .asciiz "Cooking time: "
difficulty: .asciiz "Difficulty: "
rating: .asciiz "Rating: "
listSize: .asciiz "List Size: "
emptyListWarning: .asciiz "List is empty!\n"
indexBoundWarning: .asciiz "Index out of bounds!\n"
recipeNotMatch: .asciiz "Recipe not matched!\n"
recipeMatch: .asciiz "Recipe matched!\n"
recipeAdded: .asciiz "Recipe added.\n"
recipeRemoved: .asciiz "Recipe removed.\n"
noRecipeWarning: .asciiz "No recipe to print!\n"

addressOfRecipeList: .word 0 #the address of the array of recipe list stored here!


# Recipe 1: Pancakes
r1: .asciiz "Pancakes"
r1i1: .asciiz "Flour"
r1i2: .asciiz "Milk"
r1i3: .asciiz "Eggs"
r1i4: .asciiz "Sugar"
r1i5: .asciiz "Baking powder"
r1c: .word 15							# Cooking time in minutes
r1d: .word 2							# Difficulty (scale 1-5)
r1r: .word 4							# Rating (scale 1-5)

# Recipe 2: Spaghetti Bolognese
r2: .asciiz "Spaghetti Bolognese"
r2i1: .asciiz "Spaghetti"
r2i2: .asciiz "Ground beef"
r2i3: .asciiz "Tomato sauce"
r2i4: .asciiz "Garlic"
r2i5: .asciiz "Onion"
r2c: .word 30
r2d: .word 3
r2r: .word 5

# Recipe 3: Chicken Stir-Fry
r3: .asciiz "Chicken Stir-Fry"
r3i1: .asciiz "Chicken breast"
r3i2: .asciiz "Soy sauce"
r3i3: .asciiz "Bell peppers"
r3i4: .asciiz "Broccoli"
r3i5: .asciiz "Garlic"
r3c: .word 20
r3d: .word 3
r3r: .word 4

# Recipe 4: Caesar Salad
r4: .asciiz "Caesar Salad"
r4i1: .asciiz "Romaine lettuce"
r4i2: .asciiz "Caesar dressing"
r4i3: .asciiz "Parmesan cheese"
r4i4: .asciiz "Croutons"
r4i5: .asciiz "Chicken breast (optional)"
r4c: .word 10
r4d: .word 1
r4r: .word 4

# Recipe 5: Chocolate Chip Cookies
r5: .asciiz "Chocolate Chip Cookies"
r5i1: .asciiz "Butter"
r5i2: .asciiz "Sugar"
r5i3: .asciiz "Flour"
r5i4: .asciiz "Eggs"
r5i5: .asciiz "Chocolate chips"
r5c: .word 25
r5d: .word 2
r5r: .word 5


search1: .asciiz "Caesar Salad"
search2: .asciiz "Shepherd's Pie"

.text 
main:

	# Write your instructions here!
	jal createLinkedList
	move $s0,$v0
	li $a0,5
	li $a1,4
	jal createArray
	move $a0,$v0

	la $a1,r1i1
	li $a2,0
	jal putElementToArray
	
	la $a1,r1i2
	li $a2,1
	jal putElementToArray
	
	la $a1,r1i3
	li $a2,2
	jal putElementToArray

	la $a1,r1i4
	li $a2,3
	jal putElementToArray

	la $a1,r1i5
	li $a2,4
	jal putElementToArray
	
	move $a1,$a0
	la $a0,r1
	la $a2,r1c
	la $a3,r1d
	la $s1, r1r
	addi $sp, $sp,-4
	sw $s1,0($sp)
	jal createRecipe
	addi $sp, $sp,4

	move $a0,$s0
	move $a1,$v0
	jal enqueue
	move $s0,$a0

	

	li $a0,5
	li $a1,4
	jal createArray
	move $a0,$v0

	la $a1,r2i1
	li $a2,0
	jal putElementToArray
	
	la $a1,r2i2
	li $a2,1
	jal putElementToArray
	
	la $a1,r2i3
	li $a2,2
	jal putElementToArray

	la $a1,r2i4
	li $a2,3
	jal putElementToArray

	la $a1,r2i5
	li $a2,4
	jal putElementToArray
	
	move $a1,$a0
	la $a0,r2
	la $a2,r2c
	la $a3,r2d
	la $s1, r2r
	addi $sp, $sp,-4
	sw $s1,0($sp)
	jal createRecipe
	addi $sp, $sp,4

	move $a0,$s0
	move $a1,$v0
	jal enqueue
	move $s0,$a0
	
	
	lw $t0, 0($s0)
	lw $t1, 4($s0)
	move $s0,$t1


	move $a0,$s0
	jal queueSize

	addi $sp, $sp,-4
	sw $a0,0($sp)
	li $v0,4
	la $a0,listStr
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	

	addi $sp, $sp,-4
	sw $a0,0($sp)
	li $v0,4
	la $a0,lines
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	

	move $a0,$s0
	la $a1,printRecipe
	jal traverseLinkedList

	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,lines
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	

	jal dequeue
	move $s0,$a0
	move $a0,$v0
	jal printRecipe

	move $a0,$s0
	jal queueSize

	
	addi $sp, $sp,-4
	sw $a0,0($sp)
	li $v0,4
	la $a0,listStr
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	

	addi $sp, $sp,-4
	sw $a0,0($sp)
	li $v0,4
	la $a0,lines
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	


	move $a0,$s0
	la $a1,printRecipe
	jal traverseLinkedList


	addi $sp, $sp,-4
	sw $a0,0($sp)
	li $v0,4
	la $a0,lines
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	


	jal dequeue
	move $s0,$a0
	move $a0,$v0
	jal printRecipe


	move $a0,$s0
	jal dequeue
	move $s0,$a0
	move $a0,$v0
	jal printRecipe
	

	move $a0,$s0
	jal queueSize


	addi $sp, $sp,-4
	sw $a0,0($sp)
	li $v0,4
	la $a0,listStr
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	


	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,lines
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	


	move $a0,$s0
	la $a1,printRecipe
	jal traverseLinkedList


	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,lines
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	


	li $a0,5
	li $a1,4
	jal createArray
	move $a0,$v0

	la $a1,r3i1
	li $a2,0
	jal putElementToArray
	
	la $a1,r3i2
	li $a2,1
	jal putElementToArray
	
	la $a1,r3i3
	li $a2,2
	jal putElementToArray

	la $a1,r3i4
	li $a2,3
	jal putElementToArray

	la $a1,r3i5
	li $a2,4
	jal putElementToArray
	
	move $a1,$a0
	la $a0,r3
	la $a2,r3c
	la $a3,r3d
	la $s1, r3r
	addi $sp, $sp,-4
	sw $s1,0($sp)
	jal createRecipe
	addi $sp, $sp,4

	move $a0,$s0
	move $a1,$v0
	jal enqueue
	move $s0,$a0


	move $a0,$s0
	jal queueSize

	
	addi $sp, $sp,-4
	sw $a0,0($sp)
	li $v0,4
	la $a0,listStr
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	



	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,lines
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	

	move $a0,$s0
	la $a1,printRecipe
	jal traverseLinkedList

	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,lines
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	
	

	li $a0,4
	li $a1,4
	jal createArray
	move $a0,$v0

	la $a1,r4i1
	li $a2,0
	jal putElementToArray
	
	la $a1,r4i2
	li $a2,1
	jal putElementToArray
	
	la $a1,r4i3
	li $a2,2
	jal putElementToArray

	la $a1,r4i4
	li $a2,3
	jal putElementToArray

	la $a1,r4i5
	li $a2,4
	jal putElementToArray

	
	move $a1,$a0
	la $a0,r4
	la $a2,r4c
	la $a3,r4d
	la $s1, r4r
	addi $sp, $sp,-4
	sw $s1,0($sp)
	jal createRecipe
	addi $sp, $sp,4

	move $a0,$s0
	move $a1,$v0
	jal enqueue
	move $s0,$a0

	move $a0,$s0
	jal queueSize



	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,lines
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	

	move $a0,$s0
	la $a1,printRecipe
	jal traverseLinkedList

	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,lines
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	

	li $a0,5
	li $a1,4
	jal createArray
	move $a0,$v0

	la $a1,r5i1
	li $a2,0
	jal putElementToArray
	
	la $a1,r5i2
	li $a2,1
	jal putElementToArray
	
	la $a1,r5i3
	li $a2,2
	jal putElementToArray

	la $a1,r5i4
	li $a2,3
	jal putElementToArray

	la $a1,r5i5
	li $a2,4
	jal putElementToArray

	
	move $a1,$a0
	la $a0,r5
	la $a2,r5c
	la $a3,r5d
	la $s1, r5r
	addi $sp, $sp,-4
	sw $s1,0($sp)
	jal createRecipe
	addi $sp, $sp,4

	move $a0,$s0
	move $a1,$v0
	jal enqueue
	move $s0,$a0


	move $a0,$s0
	jal queueSize



	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,lines
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	

	move $a0,$s0
	la $a1,printRecipe
	jal traverseLinkedList

	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,lines
	li $v0,4
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4	


	move $a0,$s0
	la $a1,findRecipe
	la $a2,search1
	jal traverseLinkedList

	move $a0,$s0
	la $a1,findRecipe
	la $a2,search2
	jal traverseLinkedList
	

	j mainTerminate
mainTerminate:
	li $v0, 10
	syscall




createArray:
	# Create an array
	# Inputs: $a0 - max number of elements (size), $a1 - size of elements
	# Outputs: $v0 - address of array
	
	# Write your instructions here!
	addi $sp, $sp,-4
	sw $a0,0($sp)
	addi $a0,$a0,1
	sll	$a0, $a0, 2
    li $v0, 9
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4
	sw $a0,0($v0)
	jr $ra

putElementToArray:
	# Store an element (recipe) in an array.
	# Inputs: $a0 - address of array, $a1 - element address, $a2 - index
	
	# Write your instructions here!
	blt $a2, 0, oob
	lw $t2, 0($a0)
	bge $a2, $t2, oob
	addi $t0,$a2,1
	sll	$t0, $t0, 2
	add $t1,$a0,$t0
	sw $a1, 0($t1)
	j putend
	oob:
		li $v0,4
		addi $sp, $sp,-4
		sw $a0,0($sp)
		la $a0,indexBoundWarning
		syscall
		lw $a0,0($sp)
		addi $sp, $sp,4	
	putend:
		jr $ra

createLinkedList:
	# Create a linked list.
	# Outputs: $v0 - address of linked List
	
	# Write your instructions here!
	li $v0, 9
    li $a0, 8
    syscall
    sw $zero, 0($v0)
    sw $zero, 4($v0)
	jr $ra

enqueue:
	# Inputs: $a0 - address of the linked list structure, $a1 - address of data to add
	
	# Write your instructions here!
	
	
	
	addi $sp, $sp,-4
	sw $a0,0($sp)

	li $v0, 9
    li $a0, 8
    syscall
    sw $a1, 0($v0)
    sw $zero, 4($v0)

	lw $a0,0($sp)
	addi $sp, $sp,4

	beq $a0, $zero, firstenqueue

	move $t0,$a0
	qcloop2:
		lw $t1, 4($t0)
    	beq $t1, $zero, qcloopend2
    	move $t0, $t1
    	j qcloop2
	qcloopend2:
		sw $v0,4($t0)
		j endenqueue
	firstenqueue:
		move $a0,$v0
	endenqueue:
		addi $sp, $sp,-4
		sw $a0,0($sp)
		la $a0,recipeAdded
		li $v0,4
		syscall
		lw $a0,0($sp)
		addi $sp, $sp,4
		jr $ra
	

dequeue:
	# Inputs: $a0 - address of the linked list structure
	# Outputs: $v0 - removed head node, 0 if empty
	
	# Write your instructions here!
	beq $a0, $zero, empty_list
	lw $t0, 0($a0)
	
	
	move $v0,$t0
	lw $t1, 4($a0)
	
	move $a0,$t1

	j endequeue
	empty_list:
		addi $sp, $sp,-4
		sw $a0,0($sp)
		la $a0,emptyListWarning
		li $v0,4
		syscall
		lw $a0,0($sp)
		addi $sp, $sp,4
		li $v0,0
		j endequeue
	endequeue:

		addi $sp, $sp,-8
		sw $a0,0($sp)
		sw $v0,4($sp)
		la $a0,recipeRemoved
		li $v0,4
		syscall
		lw $a0,0($sp)
		lw $v0,4($sp)
		addi $sp, $sp,8

		jr $ra

queueSize:
	# Inputs: $a0 - address of the linked list structure
	
	# Write your instructions here!
	move $t0,$a0
	li $t2,0
	qcloop:
		beq $t0, $zero, qcloopend
		addi $t2,$t2,1
		lw $t0, 4($t0)
    	j qcloop
	qcloopend:

		addi $sp, $sp,-4
		sw $a0,0($sp)
		la $a0,listSize
		li $v0,4
		syscall

		move $a0,$t2
		li $v0, 1
		syscall
		lw $a0,0($sp)
		addi $sp, $sp,4

		addi $sp, $sp,-4
		sw $a0,0($sp)
		la $a0,newLine
		li $v0,4
		syscall

		jr $ra

traverseArray:
	# Traverse and print recipes from array.
	# Inputs: $a0 - address of array, $a1 - called function
	
	# Write your instructions here!
	move $t0,$a0
	move $t1,$t0
	lw $t1,0($t1)
	addi $t0,$t0,4
	li $t2,0
	traloop:
		beq $t2,$t1,traloopend

		addi $sp, $sp,-4
		sw $a0,0($sp)
		la $a0,tab
		syscall
		lw $a0,0($sp)
		addi $sp, $sp,4

		addi $sp, $sp,-8
		sw $a0,0($sp)
		sw $ra,4($sp)
		move $a0,$t0
		jal $a1
		lw $a0,0($sp)
		lw $ra,4($sp)
		addi $sp, $sp,8

		addi $t0,$t0,4
		addi $t2,$t2,1

		addi $sp, $sp,-4
		sw $a0,0($sp)
		la $a0,newLine
		syscall
		lw $a0,0($sp)
		addi $sp, $sp,4

		j traloop

	traloopend:
		jr $ra

traverseLinkedList:
	# Traverse linked list.
	# Inputs: $a0 - head node of linked list, $a1 - called function, $a2 - extra arguments
	
	# Write your instructions here!
	move $t4,$a0
	beq $t4,$zero,emptylinkedlist
	lw $t0, 0($a0)
	

	addi $sp, $sp,-4
	sw $a0,0($sp)
	trloop:
		addi $sp,$sp,-16

		sw $ra,0($sp)
		sw $t1,4($sp)
		sw $a1,8($sp)
		sw $a2,12($sp)

		lw $a0, 0($t4)
		move $t1,$a1
		move $a1,$a2

    	jal $t1

		lw $ra,0($sp)
		lw $t1,4($sp)
		lw $a1,8($sp)
		lw $a2,12($sp)

		addi $sp,$sp,16

    	lw $t4, 4($t4)
		beq $t4, $zero, trloopend
    	j trloop
	emptylinkedlist:
		addi $sp, $sp,-4
		sw $a0,0($sp)
		la $a0,emptyListWarning
		syscall
		lw $a0,0($sp)
		addi $sp, $sp,4
	trloopend:
		lw $a0,0($sp)
		addi $sp, $sp,4
		jr $ra

compareString:
	# Compare two strings.
	# Inputs: $a0 - string 1 address, $a1 - string 2 address
	# Outputs: $v0 - 0 found, 1 not found
	
	# Write your instructions here!
	move $t0,$a0
	move $t1,$a1
	compareloop:
		lb $t2, 0($t0)
		lb $t3, 0($t1)
    	bne $t2, $t3, notequal
    	beq $t2, $zero, equal
    	addi $t0, $t0, 1   
    	addi $t1, $t1, 1           
    	j compareloop               
	notequal:
		li $v0,1
    	j cpend
	equal:
    	bne $t3, $zero, notequal
		li $v0,0
		j cpend
	cpend:
		jr $ra

createRecipe:
	# Create a recipe and store in the recipe struct.
	# Inputs: $a0 - recipe name, $a1 - address of ingredients array,
	#         $a2 - cooking time, $a3 - difficulty, 0($sp) - rating
	# Outputs: $v0 - recipe address
	
	# Write your instructions here!
	addi $sp, $sp,-4
	sw $a0,0($sp)
	li $a0,20
    li $v0, 9
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4
	sw $a0,0($v0)
	sw $a1,4($v0)
	sw $a2,8($v0)
	sw $a3,12($v0)
	lw $t0,0($sp)
	sw $t0,16($v0)
	jr $ra

findRecipe:
	# Compare two recipe names.
	# Inputs: $a0 - recipe struct address, $a1 - searched recipe name
	
	# Write your instructions here!
	addi $sp, $sp,-8
	sw $a0,0($sp)
	sw $ra,4($sp)
	lw $a0,0($a0)
	jal compareString
	lw $ra,4($sp)
	lw $a0,0($sp)
	addi $sp,$sp,8


	beq $v0, $zero, found
	notfound:
		li $v0,4
		la $a0,recipeNotMatch
		syscall
    	j frend
	found:

		addi $sp, $sp,-4
		sw $a0,0($sp)
    	li $v0,4
		la $a0,recipeMatch
		syscall
		lw $a0,0($sp)
		addi $sp, $sp,4

		addi $sp, $sp,-4
		sw $ra,0($sp)
		jal printRecipe
		lw $ra,0($sp)
		addi $sp, $sp,4

		j frend
	frend:
		jr $ra

printRecipe:
	# Print recipe details.
	# Inputs: $a0 - address of recipe struct
	
	# Write your instructions here!
	li $v0,4

	beq $a0,$zero,printrempty

	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,recipeName
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	addi $sp, $sp,-4
	sw $a0,0($sp)
	lw $a0,0($a0)
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,newLine
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,ingredients
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,newLine
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	addi $sp, $sp,-8
	sw $a0,0($sp)
	sw $ra,4($sp)


	lw $a0,4($a0)
	la $a1 printIngredient
	jal traverseArray

	
	lw $a0,0($sp)
	lw $ra,4($sp)
	addi $sp, $sp,8



	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,cookingTime
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	addi $sp, $sp,-4
	sw $a0,0($sp)
	lw $a0,8($a0)
	lw $a0,0($a0)
	li $v0,1
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	li $v0,4
	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,newLine
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4


	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,difficulty
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	addi $sp, $sp,-4
	sw $a0,0($sp)
	lw $a0,12($a0)
	lw $a0,0($a0)
	li $v0,1
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	li $v0,4
	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,newLine
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4


	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,rating
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	addi $sp, $sp,-4
	sw $a0,0($sp)
	lw $a0,16($a0)
	lw $a0,0($a0)
	li $v0,1
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	li $v0,4
	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,newLine
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	j printrend
	printrempty:
		addi $sp, $sp,-4
		sw $a0,0($sp)
		la $a0,noRecipeWarning
		syscall
		lw $a0,0($sp)
		addi $sp, $sp,4
		jr $ra
	printrend:
		jr $ra

printIngredient:
	# Print ingredient.
	# Inputs: $a0 - address of ingredient
	
	# Write your instructions here!
	li $v0,4
	addi $sp, $sp,-4
	sw $a0,0($sp)
	lw $a0,0($a0)
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4

	addi $sp, $sp,-4
	sw $a0,0($sp)
	la $a0,newLine
	syscall
	la $a0,tab
	syscall
	lw $a0,0($sp)
	addi $sp, $sp,4
	jr $ra
	