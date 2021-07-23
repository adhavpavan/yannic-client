package main

// User : Structure of User
type User struct {
	UserID       string `json:"userID"`
	Name         string `json:"name"`
	EmailID      string `json:"emailID"`
	DepartmentID string `json:"departmentID"`
	Role         string `json:"role"`
}
