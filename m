From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] fsck.f2fs: support quota
Date: Mon, 30 Oct 2017 20:42:06 -0700
Message-ID: <20171031034206.26890-4-jaegeuk@kernel.org>
References: <20171031034206.26890-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e9NRW-0004vX-AZ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:42:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e9NRP-0004yJ-BL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 03:42:22 +0000
In-Reply-To: <20171031034206.26890-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Hyojun Kim <hyojun@google.com>, Jaegeuk Kim <jaegeuk@google.com>

From: Hyojun Kim <hyojun@google.com>

This patch let fsck to check and fix quota file contents.

Signed-off-by: Hyojun Kim <hyojun@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 fsck/Makefile.am    |    3 +-
 fsck/common.h       |   30 +
 fsck/dict.c         | 1501 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/dict.h         |  144 +++++
 fsck/dqblk_v2.h     |   31 ++
 fsck/fsck.c         |  105 +++-
 fsck/fsck.h         |   10 +
 fsck/main.c         |   18 +-
 fsck/mkquota.c      |  403 ++++++++++++++
 fsck/mount.c        |   15 +-
 fsck/quotaio.c      |  221 ++++++++
 fsck/quotaio.h      |  255 +++++++++
 fsck/quotaio_tree.c |  679 +++++++++++++++++++++++
 fsck/quotaio_tree.h |   66 +++
 fsck/quotaio_v2.c   |  284 ++++++++++
 fsck/quotaio_v2.h   |   54 ++
 fsck/segment.c      |   22 +-
 include/f2fs_fs.h   |   19 +
 mkfs/f2fs_format.c  |   10 +-
 19 files changed, 3852 insertions(+), 18 deletions(-)
 create mode 100644 fsck/common.h
 create mode 100644 fsck/dict.c
 create mode 100644 fsck/dict.h
 create mode 100644 fsck/dqblk_v2.h
 create mode 100644 fsck/mkquota.c
 create mode 100644 fsck/quotaio.c
 create mode 100644 fsck/quotaio.h
 create mode 100644 fsck/quotaio_tree.c
 create mode 100644 fsck/quotaio_tree.h
 create mode 100644 fsck/quotaio_v2.c
 create mode 100644 fsck/quotaio_v2.h

diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 7abcd00..cf0f7d1 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -5,7 +5,8 @@ AM_CFLAGS = -Wall
 sbin_PROGRAMS = fsck.f2fs
 fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c f2fs.h fsck.h $(top_srcdir)/include/f2fs_fs.h	\
 		resize.c										\
-		node.c segment.c dir.c sload.c xattr.c
+		node.c segment.c dir.c sload.c xattr.c \
+		dict.c mkquota.c quotaio.c quotaio_tree.c quotaio_v2.c
 fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
 
 install-data-hook:
diff --git a/fsck/common.h b/fsck/common.h
new file mode 100644
index 0000000..19a6ecc
--- /dev/null
+++ b/fsck/common.h
@@ -0,0 +1,30 @@
+/**
+ *
+ * Various things common for all utilities
+ *
+ */
+
+#ifndef __QUOTA_COMMON_H__
+#define __QUOTA_COMMON_H__
+
+#undef DEBUG_QUOTA
+
+#ifndef __attribute__
+# if !defined __GNUC__ || __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 8) || __STRICT_ANSI__
+#  define __attribute__(x)
+# endif
+#endif
+
+#define log_err(format, arg ...)					\
+	fprintf(stderr, "[ERROR] %s:%d:%s:: " format "\n",		\
+		__FILE__, __LINE__, __func__, ## arg)
+
+#ifdef DEBUG_QUOTA
+# define log_debug(format, arg ...)					\
+	fprintf(stderr, "[DEBUG] %s:%d:%s:: " format "\n",		\
+		__FILE__, __LINE__, __func__, ## arg)
+#else
+# define log_debug(...)
+#endif
+
+#endif /* __QUOTA_COMMON_H__ */
diff --git a/fsck/dict.c b/fsck/dict.c
new file mode 100644
index 0000000..bb7600c
--- /dev/null
+++ b/fsck/dict.c
@@ -0,0 +1,1501 @@
+/*
+ * Dictionary Abstract Data Type
+ * Copyright (C) 1997 Kaz Kylheku <kaz@ashi.footprints.net>
+ *
+ * Free Software License:
+ *
+ * All rights are reserved by the author, with the following exceptions:
+ * Permission is granted to freely reproduce and distribute this software,
+ * possibly in exchange for a fee, provided that this copyright notice appears
+ * intact. Permission is also granted to adapt this software to produce
+ * derivative works, as long as the modified versions carry this copyright
+ * notice and additional notices stating that the work has been modified.
+ * This source code may be translated into executable form and incorporated
+ * into proprietary software; there is no requirement for such software to
+ * contain a copyright notice related to this source.
+ *
+ * $Id: dict.c,v 1.40.2.7 2000/11/13 01:36:44 kaz Exp $
+ * $Name: kazlib_1_20 $
+ */
+
+#define DICT_NODEBUG
+
+#include "config.h"
+#include <stdlib.h>
+#include <stddef.h>
+#ifdef DICT_NODEBUG
+#define dict_assert(x)
+#else
+#include <assert.h>
+#define dict_assert(x) assert(x)
+#endif
+#define DICT_IMPLEMENTATION
+#include "dict.h"
+#include <f2fs_fs.h>
+
+#ifdef KAZLIB_RCSID
+static const char rcsid[] = "$Id: dict.c,v 1.40.2.7 2000/11/13 01:36:44 kaz Exp $";
+#endif
+
+/*
+ * These macros provide short convenient names for structure members,
+ * which are embellished with dict_ prefixes so that they are
+ * properly confined to the documented namespace. It's legal for a
+ * program which uses dict to define, for instance, a macro called ``parent''.
+ * Such a macro would interfere with the dnode_t struct definition.
+ * In general, highly portable and reusable C modules which expose their
+ * structures need to confine structure member names to well-defined spaces.
+ * The resulting identifiers aren't necessarily convenient to use, nor
+ * readable, in the implementation, however!
+ */
+
+#define left dict_left
+#define right dict_right
+#define parent dict_parent
+#define color dict_color
+#define key dict_key
+#define data dict_data
+
+#define nilnode dict_nilnode
+#define nodecount dict_nodecount
+#define maxcount dict_maxcount
+#define compare dict_compare
+#define allocnode dict_allocnode
+#define freenode dict_freenode
+#define context dict_context
+#define dupes dict_dupes
+
+#define dictptr dict_dictptr
+
+#define dict_root(D) ((D)->nilnode.left)
+#define dict_nil(D) (&(D)->nilnode)
+#define DICT_DEPTH_MAX 64
+
+static dnode_t *dnode_alloc(void *context);
+static void dnode_free(dnode_t *node, void *context);
+
+/*
+ * Perform a ``left rotation'' adjustment on the tree.  The given node P and
+ * its right child C are rearranged so that the P instead becomes the left
+ * child of C.   The left subtree of C is inherited as the new right subtree
+ * for P.  The ordering of the keys within the tree is thus preserved.
+ */
+static void rotate_left(dnode_t *upper)
+{
+	dnode_t *lower, *lowleft, *upparent;
+
+	lower = upper->right;
+	upper->right = lowleft = lower->left;
+	lowleft->parent = upper;
+
+	lower->parent = upparent = upper->parent;
+
+	/* don't need to check for root node here because root->parent is
+	   the sentinel nil node, and root->parent->left points back to root */
+
+	if (upper == upparent->left) {
+		upparent->left = lower;
+	} else {
+		dict_assert(upper == upparent->right);
+		upparent->right = lower;
+	}
+
+	lower->left = upper;
+	upper->parent = lower;
+}
+
+/*
+ * This operation is the ``mirror'' image of rotate_left. It is
+ * the same procedure, but with left and right interchanged.
+ */
+static void rotate_right(dnode_t *upper)
+{
+	dnode_t *lower, *lowright, *upparent;
+
+	lower = upper->left;
+	upper->left = lowright = lower->right;
+	lowright->parent = upper;
+
+	lower->parent = upparent = upper->parent;
+
+	if (upper == upparent->right) {
+		upparent->right = lower;
+	} else {
+		dict_assert(upper == upparent->left);
+		upparent->left = lower;
+	}
+
+	lower->right = upper;
+	upper->parent = lower;
+}
+
+/*
+ * Do a postorder traversal of the tree rooted at the specified
+ * node and free everything under it.  Used by dict_free().
+ */
+static void free_nodes(dict_t *dict, dnode_t *node, dnode_t *nil)
+{
+	if (node == nil)
+		return;
+	free_nodes(dict, node->left, nil);
+	free_nodes(dict, node->right, nil);
+	dict->freenode(node, dict->context);
+}
+
+/*
+ * This procedure performs a verification that the given subtree is a binary
+ * search tree. It performs an inorder traversal of the tree using the
+ * dict_next() successor function, verifying that the key of each node is
+ * strictly lower than that of its successor, if duplicates are not allowed,
+ * or lower or equal if duplicates are allowed.  This function is used for
+ * debugging purposes.
+ */
+#ifndef DICT_NODEBUG
+static int verify_bintree(dict_t *dict)
+{
+	dnode_t *first, *next;
+
+	first = dict_first(dict);
+
+	if (dict->dupes) {
+		while (first && (next = dict_next(dict, first))) {
+			if (dict->compare(first->key, next->key) > 0)
+				return 0;
+			first = next;
+		}
+	} else {
+		while (first && (next = dict_next(dict, first))) {
+			if (dict->compare(first->key, next->key) >= 0)
+				return 0;
+			first = next;
+		}
+	}
+	return 1;
+}
+
+/*
+ * This function recursively verifies that the given binary subtree satisfies
+ * three of the red black properties. It checks that every red node has only
+ * black children. It makes sure that each node is either red or black. And it
+ * checks that every path has the same count of black nodes from root to leaf.
+ * It returns the blackheight of the given subtree; this allows blackheights to
+ * be computed recursively and compared for left and right siblings for
+ * mismatches. It does not check for every nil node being black, because there
+ * is only one sentinel nil node. The return value of this function is the
+ * black height of the subtree rooted at the node ``root'', or zero if the
+ * subtree is not red-black.
+ */
+static unsigned int verify_redblack(dnode_t *nil, dnode_t *root)
+{
+	unsigned height_left, height_right;
+
+	if (root != nil) {
+		height_left = verify_redblack(nil, root->left);
+		height_right = verify_redblack(nil, root->right);
+		if (height_left == 0 || height_right == 0)
+			return 0;
+		if (height_left != height_right)
+			return 0;
+		if (root->color == dnode_red) {
+			if (root->left->color != dnode_black)
+				return 0;
+			if (root->right->color != dnode_black)
+				return 0;
+			return height_left;
+		}
+		if (root->color != dnode_black)
+			return 0;
+		return height_left + 1;
+	}
+	return 1;
+}
+
+/*
+ * Compute the actual count of nodes by traversing the tree and
+ * return it. This could be compared against the stored count to
+ * detect a mismatch.
+ */
+static dictcount_t verify_node_count(dnode_t *nil, dnode_t *root)
+{
+	if (root == nil)
+		return 0;
+	else
+		return 1 + verify_node_count(nil, root->left)
+			+ verify_node_count(nil, root->right);
+}
+#endif
+
+/*
+ * Verify that the tree contains the given node. This is done by
+ * traversing all of the nodes and comparing their pointers to the
+ * given pointer. Returns 1 if the node is found, otherwise
+ * returns zero. It is intended for debugging purposes.
+ */
+static int verify_dict_has_node(dnode_t *nil, dnode_t *root, dnode_t *node)
+{
+	if (root != nil) {
+		return root == node
+			|| verify_dict_has_node(nil, root->left, node)
+			|| verify_dict_has_node(nil, root->right, node);
+	}
+	return 0;
+}
+
+#ifdef FSCK_NOTUSED
+/*
+ * Dynamically allocate and initialize a dictionary object.
+ */
+dict_t *dict_create(dictcount_t maxcount, dict_comp_t comp)
+{
+	dict_t *new = malloc(sizeof *new);
+
+	if (new) {
+		new->compare = comp;
+		new->allocnode = dnode_alloc;
+		new->freenode = dnode_free;
+		new->context = NULL;
+		new->nodecount = 0;
+		new->maxcount = maxcount;
+		new->nilnode.left = &new->nilnode;
+		new->nilnode.right = &new->nilnode;
+		new->nilnode.parent = &new->nilnode;
+		new->nilnode.color = dnode_black;
+		new->dupes = 0;
+	}
+	return new;
+}
+#endif /* FSCK_NOTUSED */
+
+/*
+ * Select a different set of node allocator routines.
+ */
+void dict_set_allocator(dict_t *dict, dnode_alloc_t al,
+		dnode_free_t fr, void *context)
+{
+	dict_assert(dict_count(dict) == 0);
+	dict_assert((al == NULL && fr == NULL) || (al != NULL && fr != NULL));
+
+	dict->allocnode = al ? al : dnode_alloc;
+	dict->freenode = fr ? fr : dnode_free;
+	dict->context = context;
+}
+
+#ifdef FSCK_NOTUSED
+/*
+ * Free a dynamically allocated dictionary object. Removing the nodes
+ * from the tree before deleting it is required.
+ */
+void dict_destroy(dict_t *dict)
+{
+	dict_assert(dict_isempty(dict));
+	free(dict);
+}
+#endif
+
+/*
+ * Free all the nodes in the dictionary by using the dictionary's
+ * installed free routine. The dictionary is emptied.
+ */
+void dict_free_nodes(dict_t *dict)
+{
+	dnode_t *nil = dict_nil(dict), *root = dict_root(dict);
+	free_nodes(dict, root, nil);
+	dict->nodecount = 0;
+	dict->nilnode.left = &dict->nilnode;
+	dict->nilnode.right = &dict->nilnode;
+}
+
+#ifdef FSCK_NOTUSED
+/*
+ * Obsolescent function, equivalent to dict_free_nodes
+ */
+void dict_free(dict_t *dict)
+{
+#ifdef KAZLIB_OBSOLESCENT_DEBUG
+	dict_assert("call to obsolescent function dict_free()" && 0);
+#endif
+	dict_free_nodes(dict);
+}
+#endif
+
+/*
+ * Initialize a user-supplied dictionary object.
+ */
+dict_t *dict_init(dict_t *dict, dictcount_t maxcount, dict_comp_t comp)
+{
+	dict->compare = comp;
+	dict->allocnode = dnode_alloc;
+	dict->freenode = dnode_free;
+	dict->context = NULL;
+	dict->nodecount = 0;
+	dict->maxcount = maxcount;
+	dict->nilnode.left = &dict->nilnode;
+	dict->nilnode.right = &dict->nilnode;
+	dict->nilnode.parent = &dict->nilnode;
+	dict->nilnode.color = dnode_black;
+	dict->dupes = 0;
+	return dict;
+}
+
+#ifdef FSCK_NOTUSED
+/*
+ * Initialize a dictionary in the likeness of another dictionary
+ */
+void dict_init_like(dict_t *dict, const dict_t *template)
+{
+	dict->compare = template->compare;
+	dict->allocnode = template->allocnode;
+	dict->freenode = template->freenode;
+	dict->context = template->context;
+	dict->nodecount = 0;
+	dict->maxcount = template->maxcount;
+	dict->nilnode.left = &dict->nilnode;
+	dict->nilnode.right = &dict->nilnode;
+	dict->nilnode.parent = &dict->nilnode;
+	dict->nilnode.color = dnode_black;
+	dict->dupes = template->dupes;
+
+	dict_assert(dict_similar(dict, template));
+}
+
+/*
+ * Remove all nodes from the dictionary (without freeing them in any way).
+ */
+static void dict_clear(dict_t *dict)
+{
+	dict->nodecount = 0;
+	dict->nilnode.left = &dict->nilnode;
+	dict->nilnode.right = &dict->nilnode;
+	dict->nilnode.parent = &dict->nilnode;
+	dict_assert(dict->nilnode.color == dnode_black);
+}
+#endif /* FSCK_NOTUSED */
+
+/*
+ * Verify the integrity of the dictionary structure.  This is provided for
+ * debugging purposes, and should be placed in assert statements.   Just because
+ * this function succeeds doesn't mean that the tree is not corrupt. Certain
+ * corruptions in the tree may simply cause undefined behavior.
+ */
+#ifndef DICT_NODEBUG
+int dict_verify(dict_t *dict)
+{
+	dnode_t *nil = dict_nil(dict), *root = dict_root(dict);
+
+	/* check that the sentinel node and root node are black */
+	if (root->color != dnode_black)
+		return 0;
+	if (nil->color != dnode_black)
+		return 0;
+	if (nil->right != nil)
+		return 0;
+	/* nil->left is the root node; check that its parent pointer is nil */
+	if (nil->left->parent != nil)
+		return 0;
+	/* perform a weak test that the tree is a binary search tree */
+	if (!verify_bintree(dict))
+		return 0;
+	/* verify that the tree is a red-black tree */
+	if (!verify_redblack(nil, root))
+		return 0;
+	if (verify_node_count(nil, root) != dict_count(dict))
+		return 0;
+	return 1;
+}
+#endif /* DICT_NODEBUG */
+
+#ifdef FSCK_NOTUSED
+/*
+ * Determine whether two dictionaries are similar: have the same comparison and
+ * allocator functions, and same status as to whether duplicates are allowed.
+ */
+int dict_similar(const dict_t *left, const dict_t *right)
+{
+	if (left->compare != right->compare)
+		return 0;
+
+	if (left->allocnode != right->allocnode)
+		return 0;
+
+	if (left->freenode != right->freenode)
+		return 0;
+
+	if (left->context != right->context)
+		return 0;
+
+	if (left->dupes != right->dupes)
+		return 0;
+
+	return 1;
+}
+#endif /* FSCK_NOTUSED */
+
+/*
+ * Locate a node in the dictionary having the given key.
+ * If the node is not found, a null a pointer is returned (rather than
+ * a pointer that dictionary's nil sentinel node), otherwise a pointer to the
+ * located node is returned.
+ */
+dnode_t *dict_lookup(dict_t *dict, const void *key)
+{
+	dnode_t *root = dict_root(dict);
+	dnode_t *nil = dict_nil(dict);
+	dnode_t *saved;
+	int result;
+
+	/* simple binary search adapted for trees that contain duplicate keys */
+
+	while (root != nil) {
+		result = dict->compare(key, root->key);
+		if (result < 0)
+			root = root->left;
+		else if (result > 0)
+			root = root->right;
+		else {
+			if (!dict->dupes) {	/* no duplicates, return match		*/
+				return root;
+			} else {		/* could be dupes, find leftmost one	*/
+				do {
+					saved = root;
+					root = root->left;
+					while (root != nil && dict->compare(key, root->key))
+						root = root->right;
+				} while (root != nil);
+				return saved;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+#ifdef FSCK_NOTUSED
+/*
+ * Look for the node corresponding to the lowest key that is equal to or
+ * greater than the given key.  If there is no such node, return null.
+ */
+dnode_t *dict_lower_bound(dict_t *dict, const void *key)
+{
+	dnode_t *root = dict_root(dict);
+	dnode_t *nil = dict_nil(dict);
+	dnode_t *tentative = 0;
+
+	while (root != nil) {
+		int result = dict->compare(key, root->key);
+
+		if (result > 0) {
+			root = root->right;
+		} else if (result < 0) {
+			tentative = root;
+			root = root->left;
+		} else {
+			if (!dict->dupes) {
+				return root;
+			} else {
+				tentative = root;
+				root = root->left;
+			}
+		}
+	}
+
+	return tentative;
+}
+
+/*
+ * Look for the node corresponding to the greatest key that is equal to or
+ * lower than the given key.  If there is no such node, return null.
+ */
+dnode_t *dict_upper_bound(dict_t *dict, const void *key)
+{
+	dnode_t *root = dict_root(dict);
+	dnode_t *nil = dict_nil(dict);
+	dnode_t *tentative = 0;
+
+	while (root != nil) {
+		int result = dict->compare(key, root->key);
+
+		if (result < 0) {
+			root = root->left;
+		} else if (result > 0) {
+			tentative = root;
+			root = root->right;
+		} else {
+			if (!dict->dupes) {
+				return root;
+			} else {
+				tentative = root;
+				root = root->right;
+			}
+		}
+	}
+
+	return tentative;
+}
+#endif
+
+/*
+ * Insert a node into the dictionary. The node should have been
+ * initialized with a data field. All other fields are ignored.
+ * The behavior is undefined if the user attempts to insert into
+ * a dictionary that is already full (for which the dict_isfull()
+ * function returns true).
+ */
+void dict_insert(dict_t *dict, dnode_t *node, const void *key)
+{
+	dnode_t *where = dict_root(dict), *nil = dict_nil(dict);
+	dnode_t *parent = nil, *uncle, *grandpa;
+	int result = -1;
+
+	node->key = key;
+
+	dict_assert(!dict_isfull(dict));
+	dict_assert(!dict_contains(dict, node));
+	dict_assert(!dnode_is_in_a_dict(node));
+
+	/* basic binary tree insert */
+
+	while (where != nil) {
+		parent = where;
+		result = dict->compare(key, where->key);
+		/* trap attempts at duplicate key insertion unless it's explicitly allowed */
+		dict_assert(dict->dupes || result != 0);
+		if (result < 0)
+			where = where->left;
+		else
+			where = where->right;
+	}
+
+	dict_assert(where == nil);
+
+	if (result < 0)
+		parent->left = node;
+	else
+		parent->right = node;
+
+	node->parent = parent;
+	node->left = nil;
+	node->right = nil;
+
+	dict->nodecount++;
+
+	/* red black adjustments */
+
+	node->color = dnode_red;
+
+	while (parent->color == dnode_red) {
+		grandpa = parent->parent;
+		if (parent == grandpa->left) {
+			uncle = grandpa->right;
+			if (uncle->color == dnode_red) {	/* red parent, red uncle */
+				parent->color = dnode_black;
+				uncle->color = dnode_black;
+				grandpa->color = dnode_red;
+				node = grandpa;
+				parent = grandpa->parent;
+			} else {				/* red parent, black uncle */
+				if (node == parent->right) {
+					rotate_left(parent);
+					parent = node;
+					dict_assert(grandpa == parent->parent);
+					/* rotation between parent and child preserves grandpa */
+				}
+				parent->color = dnode_black;
+				grandpa->color = dnode_red;
+				rotate_right(grandpa);
+				break;
+			}
+		} else { 	/* symmetric cases: parent == parent->parent->right */
+			uncle = grandpa->left;
+			if (uncle->color == dnode_red) {
+				parent->color = dnode_black;
+				uncle->color = dnode_black;
+				grandpa->color = dnode_red;
+				node = grandpa;
+				parent = grandpa->parent;
+			} else {
+				if (node == parent->left) {
+					rotate_right(parent);
+					parent = node;
+					dict_assert(grandpa == parent->parent);
+				}
+				parent->color = dnode_black;
+				grandpa->color = dnode_red;
+				rotate_left(grandpa);
+				break;
+			}
+		}
+	}
+
+	dict_root(dict)->color = dnode_black;
+
+	dict_assert(dict_verify(dict));
+}
+
+#ifdef FSCK_NOTUSED
+/*
+ * Delete the given node from the dictionary. If the given node does not belong
+ * to the given dictionary, undefined behavior results.  A pointer to the
+ * deleted node is returned.
+ */
+dnode_t *dict_delete(dict_t *dict, dnode_t *delete)
+{
+	dnode_t *nil = dict_nil(dict), *child, *delparent = delete->parent;
+
+	/* basic deletion */
+
+	dict_assert(!dict_isempty(dict));
+	dict_assert(dict_contains(dict, delete));
+
+	/*
+	 * If the node being deleted has two children, then we replace it with its
+	 * successor (i.e. the leftmost node in the right subtree.) By doing this,
+	 * we avoid the traditional algorithm under which the successor's key and
+	 * value *only* move to the deleted node and the successor is spliced out
+	 * from the tree. We cannot use this approach because the user may hold
+	 * pointers to the successor, or nodes may be inextricably tied to some
+	 * other structures by way of embedding, etc. So we must splice out the
+	 * node we are given, not some other node, and must not move contents from
+	 * one node to another behind the user's back.
+	 */
+
+	if (delete->left != nil && delete->right != nil) {
+		dnode_t *next = dict_next(dict, delete);
+		dnode_t *nextparent = next->parent;
+		dnode_color_t nextcolor = next->color;
+
+		dict_assert(next != nil);
+		dict_assert(next->parent != nil);
+		dict_assert(next->left == nil);
+
+		/*
+		 * First, splice out the successor from the tree completely, by
+		 * moving up its right child into its place.
+		 */
+
+		child = next->right;
+		child->parent = nextparent;
+
+		if (nextparent->left == next) {
+			nextparent->left = child;
+		} else {
+			dict_assert(nextparent->right == next);
+			nextparent->right = child;
+		}
+
+		/*
+		 * Now that the successor has been extricated from the tree, install it
+		 * in place of the node that we want deleted.
+		 */
+
+		next->parent = delparent;
+		next->left = delete->left;
+		next->right = delete->right;
+		next->left->parent = next;
+		next->right->parent = next;
+		next->color = delete->color;
+		delete->color = nextcolor;
+
+		if (delparent->left == delete) {
+			delparent->left = next;
+		} else {
+			dict_assert(delparent->right == delete);
+			delparent->right = next;
+		}
+
+	} else {
+		dict_assert(delete != nil);
+		dict_assert(delete->left == nil || delete->right == nil);
+
+		child = (delete->left != nil) ? delete->left : delete->right;
+
+		child->parent = delparent = delete->parent;
+
+		if (delete == delparent->left) {
+			delparent->left = child;
+		} else {
+			dict_assert(delete == delparent->right);
+			delparent->right = child;
+		}
+	}
+
+	delete->parent = NULL;
+	delete->right = NULL;
+	delete->left = NULL;
+
+	dict->nodecount--;
+
+	dict_assert(verify_bintree(dict));
+
+	/* red-black adjustments */
+
+	if (delete->color == dnode_black) {
+		dnode_t *parent, *sister;
+
+		dict_root(dict)->color = dnode_red;
+
+		while (child->color == dnode_black) {
+			parent = child->parent;
+			if (child == parent->left) {
+				sister = parent->right;
+				dict_assert(sister != nil);
+				if (sister->color == dnode_red) {
+					sister->color = dnode_black;
+					parent->color = dnode_red;
+					rotate_left(parent);
+					sister = parent->right;
+					dict_assert(sister != nil);
+				}
+				if (sister->left->color == dnode_black
+						&& sister->right->color == dnode_black) {
+					sister->color = dnode_red;
+					child = parent;
+				} else {
+					if (sister->right->color == dnode_black) {
+						dict_assert(sister->left->color == dnode_red);
+						sister->left->color = dnode_black;
+						sister->color = dnode_red;
+						rotate_right(sister);
+						sister = parent->right;
+						dict_assert(sister != nil);
+					}
+					sister->color = parent->color;
+					sister->right->color = dnode_black;
+					parent->color = dnode_black;
+					rotate_left(parent);
+					break;
+				}
+			} else {	/* symmetric case: child == child->parent->right */
+				dict_assert(child == parent->right);
+				sister = parent->left;
+				dict_assert(sister != nil);
+				if (sister->color == dnode_red) {
+					sister->color = dnode_black;
+					parent->color = dnode_red;
+					rotate_right(parent);
+					sister = parent->left;
+					dict_assert(sister != nil);
+				}
+				if (sister->right->color == dnode_black
+						&& sister->left->color == dnode_black) {
+					sister->color = dnode_red;
+					child = parent;
+				} else {
+					if (sister->left->color == dnode_black) {
+						dict_assert(sister->right->color == dnode_red);
+						sister->right->color = dnode_black;
+						sister->color = dnode_red;
+						rotate_left(sister);
+						sister = parent->left;
+						dict_assert(sister != nil);
+					}
+					sister->color = parent->color;
+					sister->left->color = dnode_black;
+					parent->color = dnode_black;
+					rotate_right(parent);
+					break;
+				}
+			}
+		}
+
+		child->color = dnode_black;
+		dict_root(dict)->color = dnode_black;
+	}
+
+	dict_assert(dict_verify(dict));
+
+	return delete;
+}
+#endif /* FSCK_NOTUSED */
+
+/*
+ * Allocate a node using the dictionary's allocator routine, give it
+ * the data item.
+ */
+int dict_alloc_insert(dict_t *dict, const void *key, void *data)
+{
+	dnode_t *node = dict->allocnode(dict->context);
+
+	if (node) {
+		dnode_init(node, data);
+		dict_insert(dict, node, key);
+		return 1;
+	}
+	return 0;
+}
+
+#ifdef FSCK_NOTUSED
+void dict_delete_free(dict_t *dict, dnode_t *node)
+{
+	dict_delete(dict, node);
+	dict->freenode(node, dict->context);
+}
+#endif
+
+/*
+ * Return the node with the lowest (leftmost) key. If the dictionary is empty
+ * (that is, dict_isempty(dict) returns 1) a null pointer is returned.
+ */
+dnode_t *dict_first(dict_t *dict)
+{
+	dnode_t *nil = dict_nil(dict), *root = dict_root(dict), *left;
+
+	if (root != nil)
+		while ((left = root->left) != nil)
+			root = left;
+
+	return (root == nil) ? NULL : root;
+}
+
+/*
+ * Return the node with the highest (rightmost) key. If the dictionary is empty
+ * (that is, dict_isempty(dict) returns 1) a null pointer is returned.
+ */
+dnode_t *dict_last(dict_t *dict)
+{
+	dnode_t *nil = dict_nil(dict), *root = dict_root(dict), *right;
+
+	if (root != nil)
+		while ((right = root->right) != nil)
+			root = right;
+
+	return (root == nil) ? NULL : root;
+}
+
+/*
+ * Return the given node's successor node---the node which has the
+ * next key in the the left to right ordering. If the node has
+ * no successor, a null pointer is returned rather than a pointer to
+ * the nil node.
+ */
+dnode_t *dict_next(dict_t *dict, dnode_t *curr)
+{
+	dnode_t *nil = dict_nil(dict), *parent, *left;
+
+	if (curr->right != nil) {
+		curr = curr->right;
+		while ((left = curr->left) != nil)
+			curr = left;
+		return curr;
+	}
+
+	parent = curr->parent;
+
+	while (parent != nil && curr == parent->right) {
+		curr = parent;
+		parent = curr->parent;
+	}
+
+	return (parent == nil) ? NULL : parent;
+}
+
+/*
+ * Return the given node's predecessor, in the key order.
+ * The nil sentinel node is returned if there is no predecessor.
+ */
+dnode_t *dict_prev(dict_t *dict, dnode_t *curr)
+{
+	dnode_t *nil = dict_nil(dict), *parent, *right;
+
+	if (curr->left != nil) {
+		curr = curr->left;
+		while ((right = curr->right) != nil)
+			curr = right;
+		return curr;
+	}
+
+	parent = curr->parent;
+
+	while (parent != nil && curr == parent->left) {
+		curr = parent;
+		parent = curr->parent;
+	}
+
+	return (parent == nil) ? NULL : parent;
+}
+
+void dict_allow_dupes(dict_t *dict)
+{
+	dict->dupes = 1;
+}
+
+#undef dict_count
+#undef dict_isempty
+#undef dict_isfull
+#undef dnode_get
+#undef dnode_put
+#undef dnode_getkey
+
+dictcount_t dict_count(dict_t *dict)
+{
+	return dict->nodecount;
+}
+
+int dict_isempty(dict_t *dict)
+{
+	return dict->nodecount == 0;
+}
+
+int dict_isfull(dict_t *dict)
+{
+	return dict->nodecount == dict->maxcount;
+}
+
+int dict_contains(dict_t *dict, dnode_t *node)
+{
+	return verify_dict_has_node(dict_nil(dict), dict_root(dict), node);
+}
+
+static dnode_t *dnode_alloc(void *UNUSED(context))
+{
+	return malloc(sizeof *dnode_alloc(NULL));
+}
+
+static void dnode_free(dnode_t *node, void *UNUSED(context))
+{
+	free(node);
+}
+
+dnode_t *dnode_create(void *data)
+{
+	dnode_t *new = malloc(sizeof *new);
+	if (new) {
+		new->data = data;
+		new->parent = NULL;
+		new->left = NULL;
+		new->right = NULL;
+	}
+	return new;
+}
+
+dnode_t *dnode_init(dnode_t *dnode, void *data)
+{
+	dnode->data = data;
+	dnode->parent = NULL;
+	dnode->left = NULL;
+	dnode->right = NULL;
+	return dnode;
+}
+
+void dnode_destroy(dnode_t *dnode)
+{
+	dict_assert(!dnode_is_in_a_dict(dnode));
+	free(dnode);
+}
+
+void *dnode_get(dnode_t *dnode)
+{
+	return dnode->data;
+}
+
+const void *dnode_getkey(dnode_t *dnode)
+{
+	return dnode->key;
+}
+
+#ifdef FSCK_NOTUSED
+void dnode_put(dnode_t *dnode, void *data)
+{
+	dnode->data = data;
+}
+#endif
+
+#ifndef DICT_NODEBUG
+int dnode_is_in_a_dict(dnode_t *dnode)
+{
+	return (dnode->parent && dnode->left && dnode->right);
+}
+#endif
+
+#ifdef FSCK_NOTUSED
+void dict_process(dict_t *dict, void *context, dnode_process_t function)
+{
+	dnode_t *node = dict_first(dict), *next;
+
+	while (node != NULL) {
+		/* check for callback function deleting	*/
+		/* the next node from under us		*/
+		dict_assert(dict_contains(dict, node));
+		next = dict_next(dict, node);
+		function(dict, node, context);
+		node = next;
+	}
+}
+
+static void load_begin_internal(dict_load_t *load, dict_t *dict)
+{
+	load->dictptr = dict;
+	load->nilnode.left = &load->nilnode;
+	load->nilnode.right = &load->nilnode;
+}
+
+void dict_load_begin(dict_load_t *load, dict_t *dict)
+{
+	dict_assert(dict_isempty(dict));
+	load_begin_internal(load, dict);
+}
+
+void dict_load_next(dict_load_t *load, dnode_t *newnode, const void *key)
+{
+	dict_t *dict = load->dictptr;
+	dnode_t *nil = &load->nilnode;
+
+	dict_assert(!dnode_is_in_a_dict(newnode));
+	dict_assert(dict->nodecount < dict->maxcount);
+
+#ifndef DICT_NODEBUG
+	if (dict->nodecount > 0) {
+		if (dict->dupes)
+			dict_assert(dict->compare(nil->left->key, key) <= 0);
+		else
+			dict_assert(dict->compare(nil->left->key, key) < 0);
+	}
+#endif
+
+	newnode->key = key;
+	nil->right->left = newnode;
+	nil->right = newnode;
+	newnode->left = nil;
+	dict->nodecount++;
+}
+
+void dict_load_end(dict_load_t *load)
+{
+	dict_t *dict = load->dictptr;
+	dnode_t *tree[DICT_DEPTH_MAX] = { 0 };
+	dnode_t *curr, *dictnil = dict_nil(dict), *loadnil = &load->nilnode, *next;
+	dnode_t *complete = 0;
+	dictcount_t fullcount = DICTCOUNT_T_MAX, nodecount = dict->nodecount;
+	dictcount_t botrowcount;
+	unsigned baselevel = 0, level = 0, i;
+
+	dict_assert(dnode_red == 0 && dnode_black == 1);
+
+	while (fullcount >= nodecount && fullcount)
+		fullcount >>= 1;
+
+	botrowcount = nodecount - fullcount;
+
+	for (curr = loadnil->left; curr != loadnil; curr = next) {
+		next = curr->left;
+
+		if (complete == NULL && botrowcount-- == 0) {
+			dict_assert(baselevel == 0);
+			dict_assert(level == 0);
+			baselevel = level = 1;
+			complete = tree[0];
+
+			if (complete != 0) {
+				tree[0] = 0;
+				complete->right = dictnil;
+				while (tree[level] != 0) {
+					tree[level]->right = complete;
+					complete->parent = tree[level];
+					complete = tree[level];
+					tree[level++] = 0;
+				}
+			}
+		}
+
+		if (complete == NULL) {
+			curr->left = dictnil;
+			curr->right = dictnil;
+			curr->color = level % 2;
+			complete = curr;
+
+			dict_assert(level == baselevel);
+			while (tree[level] != 0) {
+				tree[level]->right = complete;
+				complete->parent = tree[level];
+				complete = tree[level];
+				tree[level++] = 0;
+			}
+		} else {
+			curr->left = complete;
+			curr->color = (level + 1) % 2;
+			complete->parent = curr;
+			tree[level] = curr;
+			complete = 0;
+			level = baselevel;
+		}
+	}
+
+	if (complete == NULL)
+		complete = dictnil;
+
+	for (i = 0; i < DICT_DEPTH_MAX; i++) {
+		if (tree[i] != 0) {
+			tree[i]->right = complete;
+			complete->parent = tree[i];
+			complete = tree[i];
+		}
+	}
+
+	dictnil->color = dnode_black;
+	dictnil->right = dictnil;
+	complete->parent = dictnil;
+	complete->color = dnode_black;
+	dict_root(dict) = complete;
+
+	dict_assert(dict_verify(dict));
+}
+
+void dict_merge(dict_t *dest, dict_t *source)
+{
+	dict_load_t load;
+	dnode_t *leftnode = dict_first(dest), *rightnode = dict_first(source);
+
+	dict_assert(dict_similar(dest, source));
+
+	if (source == dest)
+		return;
+
+	dest->nodecount = 0;
+	load_begin_internal(&load, dest);
+
+	for (;;) {
+		if (leftnode != NULL && rightnode != NULL) {
+			if (dest->compare(leftnode->key, rightnode->key) < 0)
+				goto copyleft;
+			else
+				goto copyright;
+		} else if (leftnode != NULL) {
+			goto copyleft;
+		} else if (rightnode != NULL) {
+			goto copyright;
+		} else {
+			dict_assert(leftnode == NULL && rightnode == NULL);
+			break;
+		}
+
+copyleft:
+		{
+			dnode_t *next = dict_next(dest, leftnode);
+#ifndef DICT_NODEBUG
+			leftnode->left = NULL;	/* suppress assertion in dict_load_next */
+#endif
+			dict_load_next(&load, leftnode, leftnode->key);
+			leftnode = next;
+			continue;
+		}
+
+copyright:
+		{
+			dnode_t *next = dict_next(source, rightnode);
+#ifndef DICT_NODEBUG
+			rightnode->left = NULL;
+#endif
+			dict_load_next(&load, rightnode, rightnode->key);
+			rightnode = next;
+			continue;
+		}
+	}
+
+	dict_clear(source);
+	dict_load_end(&load);
+}
+#endif /* FSCK_NOTUSED */
+
+#ifdef KAZLIB_TEST_MAIN
+
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <stdarg.h>
+
+typedef char input_t[256];
+
+static int tokenize(char *string, ...)
+{
+	char **tokptr;
+	va_list arglist;
+	int tokcount = 0;
+
+	va_start(arglist, string);
+	tokptr = va_arg(arglist, char **);
+	while (tokptr) {
+		while (*string && isspace((unsigned char) *string))
+			string++;
+		if (!*string)
+			break;
+		*tokptr = string;
+		while (*string && !isspace((unsigned char) *string))
+			string++;
+		tokptr = va_arg(arglist, char **);
+		tokcount++;
+		if (!*string)
+			break;
+		*string++ = 0;
+	}
+	va_end(arglist);
+
+	return tokcount;
+}
+
+static int comparef(const void *key1, const void *key2)
+{
+	return strcmp(key1, key2);
+}
+
+static char *dupstring(char *str)
+{
+	int sz = strlen(str) + 1;
+	char *new = malloc(sz);
+	if (new)
+		memcpy(new, str, sz);
+	return new;
+}
+
+static dnode_t *new_node(void *c)
+{
+	static dnode_t few[5];
+	static int count;
+
+	if (count < 5)
+		return few + count++;
+
+	return NULL;
+}
+
+static void del_node(dnode_t *n, void *c)
+{
+}
+
+static int prompt = 0;
+
+static void construct(dict_t *d)
+{
+	input_t in;
+	int done = 0;
+	dict_load_t dl;
+	dnode_t *dn;
+	char *tok1, *tok2, *val;
+	const char *key;
+	char *help =
+		"p                      turn prompt on\n"
+		"q                      finish construction\n"
+		"a <key> <val>          add new entry\n";
+
+	if (!dict_isempty(d))
+		puts("warning: dictionary not empty!");
+
+	dict_load_begin(&dl, d);
+
+	while (!done) {
+		if (prompt)
+			putchar('>');
+		fflush(stdout);
+
+		if (!fgets(in, sizeof(input_t), stdin))
+			break;
+
+		switch (in[0]) {
+			case '?':
+				puts(help);
+				break;
+			case 'p':
+				prompt = 1;
+				break;
+			case 'q':
+				done = 1;
+				break;
+			case 'a':
+				if (tokenize(in+1, &tok1, &tok2, (char **) 0) != 2) {
+					puts("what?");
+					break;
+				}
+				key = dupstring(tok1);
+				val = dupstring(tok2);
+				dn = dnode_create(val);
+
+				if (!key || !val || !dn) {
+					puts("out of memory");
+					free((void *) key);
+					free(val);
+					if (dn)
+						dnode_destroy(dn);
+				}
+
+				dict_load_next(&dl, dn, key);
+				break;
+			default:
+				putchar('?');
+				putchar('\n');
+				break;
+		}
+	}
+
+	dict_load_end(&dl);
+}
+
+int main(void)
+{
+	input_t in;
+	dict_t darray[10];
+	dict_t *d = &darray[0];
+	dnode_t *dn;
+	int i;
+	char *tok1, *tok2, *val;
+	const char *key;
+
+	char *help =
+		"a <key> <val>          add value to dictionary\n"
+		"d <key>                delete value from dictionary\n"
+		"l <key>                lookup value in dictionary\n"
+		"( <key>                lookup lower bound\n"
+		") <key>                lookup upper bound\n"
+		"# <num>                switch to alternate dictionary (0-9)\n"
+		"j <num> <num>          merge two dictionaries\n"
+		"f                      free the whole dictionary\n"
+		"k                      allow duplicate keys\n"
+		"c                      show number of entries\n"
+		"t                      dump whole dictionary in sort order\n"
+		"m                      make dictionary out of sorted items\n"
+		"p                      turn prompt on\n"
+		"s                      switch to non-functioning allocator\n"
+		"q                      quit";
+
+	for (i = 0; i < sizeof darray / sizeof *darray; i++)
+		dict_init(&darray[i], DICTCOUNT_T_MAX, comparef);
+
+	for (;;) {
+		if (prompt)
+			putchar('>');
+		fflush(stdout);
+
+		if (!fgets(in, sizeof(input_t), stdin))
+			break;
+
+		switch(in[0]) {
+			case '?':
+				puts(help);
+				break;
+			case 'a':
+				if (tokenize(in+1, &tok1, &tok2, (char **) 0) != 2) {
+					puts("what?");
+					break;
+				}
+				key = dupstring(tok1);
+				val = dupstring(tok2);
+
+				if (!key || !val) {
+					puts("out of memory");
+					free((void *) key);
+					free(val);
+				}
+
+				if (!dict_alloc_insert(d, key, val)) {
+					puts("dict_alloc_insert failed");
+					free((void *) key);
+					free(val);
+					break;
+				}
+				break;
+			case 'd':
+				if (tokenize(in+1, &tok1, (char **) 0) != 1) {
+					puts("what?");
+					break;
+				}
+				dn = dict_lookup(d, tok1);
+				if (!dn) {
+					puts("dict_lookup failed");
+					break;
+				}
+				val = dnode_get(dn);
+				key = dnode_getkey(dn);
+				dict_delete_free(d, dn);
+
+				free(val);
+				free((void *) key);
+				break;
+			case 'f':
+				dict_free(d);
+				break;
+			case 'l':
+			case '(':
+			case ')':
+				if (tokenize(in+1, &tok1, (char **) 0) != 1) {
+					puts("what?");
+					break;
+				}
+				dn = 0;
+				switch (in[0]) {
+					case 'l':
+						dn = dict_lookup(d, tok1);
+						break;
+					case '(':
+						dn = dict_lower_bound(d, tok1);
+						break;
+					case ')':
+						dn = dict_upper_bound(d, tok1);
+						break;
+				}
+				if (!dn) {
+					puts("lookup failed");
+					break;
+				}
+				val = dnode_get(dn);
+				puts(val);
+				break;
+			case 'm':
+				construct(d);
+				break;
+			case 'k':
+				dict_allow_dupes(d);
+				break;
+			case 'c':
+				printf("%lu\n", (unsigned long) dict_count(d));
+				break;
+			case 't':
+				for (dn = dict_first(d); dn; dn = dict_next(d, dn)) {
+					printf("%s\t%s\n", (char *) dnode_getkey(dn),
+							(char *) dnode_get(dn));
+				}
+				break;
+			case 'q':
+				exit(0);
+				break;
+			case '\0':
+				break;
+			case 'p':
+				prompt = 1;
+				break;
+			case 's':
+				dict_set_allocator(d, new_node, del_node, NULL);
+				break;
+			case '#':
+				if (tokenize(in+1, &tok1, (char **) 0) != 1) {
+					puts("what?");
+					break;
+				} else {
+					int dictnum = atoi(tok1);
+					if (dictnum < 0 || dictnum > 9) {
+						puts("invalid number");
+						break;
+					}
+					d = &darray[dictnum];
+				}
+				break;
+			case 'j':
+				if (tokenize(in+1, &tok1, &tok2, (char **) 0) != 2) {
+					puts("what?");
+					break;
+				} else {
+					int dict1 = atoi(tok1), dict2 = atoi(tok2);
+					if (dict1 < 0 || dict1 > 9 || dict2 < 0 || dict2 > 9) {
+						puts("invalid number");
+						break;
+					}
+					dict_merge(&darray[dict1], &darray[dict2]);
+				}
+				break;
+			default:
+				putchar('?');
+				putchar('\n');
+				break;
+		}
+	}
+
+	return 0;
+}
+
+#endif
diff --git a/fsck/dict.h b/fsck/dict.h
new file mode 100644
index 0000000..c59e1a2
--- /dev/null
+++ b/fsck/dict.h
@@ -0,0 +1,144 @@
+/*
+ * Dictionary Abstract Data Type
+ * Copyright (C) 1997 Kaz Kylheku <kaz@ashi.footprints.net>
+ *
+ * Free Software License:
+ *
+ * All rights are reserved by the author, with the following exceptions:
+ * Permission is granted to freely reproduce and distribute this software,
+ * possibly in exchange for a fee, provided that this copyright notice appears
+ * intact. Permission is also granted to adapt this software to produce
+ * derivative works, as long as the modified versions carry this copyright
+ * notice and additional notices stating that the work has been modified.
+ * This source code may be translated into executable form and incorporated
+ * into proprietary software; there is no requirement for such software to
+ * contain a copyright notice related to this source.
+ *
+ * $Id: dict.h,v 1.22.2.6 2000/11/13 01:36:44 kaz Exp $
+ * $Name: kazlib_1_20 $
+ */
+
+#ifndef DICT_H
+#define DICT_H
+
+#include <limits.h>
+#ifdef KAZLIB_SIDEEFFECT_DEBUG
+#include "sfx.h"
+#endif
+
+/*
+ * Blurb for inclusion into C++ translation units
+ */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef unsigned long dictcount_t;
+#define DICTCOUNT_T_MAX ULONG_MAX
+
+/*
+ * The dictionary is implemented as a red-black tree
+ */
+
+typedef enum { dnode_red, dnode_black } dnode_color_t;
+
+typedef struct dnode_t {
+#if defined(DICT_IMPLEMENTATION) || !defined(KAZLIB_OPAQUE_DEBUG)
+	struct dnode_t *dict_left;
+	struct dnode_t *dict_right;
+	struct dnode_t *dict_parent;
+	dnode_color_t dict_color;
+	const void *dict_key;
+	void *dict_data;
+#else
+	int dict_dummy;
+#endif
+} dnode_t;
+
+typedef int (*dict_comp_t)(const void *, const void *);
+typedef dnode_t *(*dnode_alloc_t)(void *);
+typedef void (*dnode_free_t)(dnode_t *, void *);
+
+typedef struct dict_t {
+#if defined(DICT_IMPLEMENTATION) || !defined(KAZLIB_OPAQUE_DEBUG)
+	dnode_t dict_nilnode;
+	dictcount_t dict_nodecount;
+	dictcount_t dict_maxcount;
+	dict_comp_t dict_compare;
+	dnode_alloc_t dict_allocnode;
+	dnode_free_t dict_freenode;
+	void *dict_context;
+	int dict_dupes;
+#else
+	int dict_dummmy;
+#endif
+} dict_t;
+
+typedef void (*dnode_process_t)(dict_t *, dnode_t *, void *);
+
+typedef struct dict_load_t {
+#if defined(DICT_IMPLEMENTATION) || !defined(KAZLIB_OPAQUE_DEBUG)
+	dict_t *dict_dictptr;
+	dnode_t dict_nilnode;
+#else
+	int dict_dummmy;
+#endif
+} dict_load_t;
+
+extern dict_t *dict_create(dictcount_t, dict_comp_t);
+extern void dict_set_allocator(dict_t *, dnode_alloc_t, dnode_free_t, void *);
+extern void dict_destroy(dict_t *);
+extern void dict_free_nodes(dict_t *);
+extern void dict_free(dict_t *);
+extern dict_t *dict_init(dict_t *, dictcount_t, dict_comp_t);
+extern void dict_init_like(dict_t *, const dict_t *);
+extern int dict_verify(dict_t *);
+extern int dict_similar(const dict_t *, const dict_t *);
+extern dnode_t *dict_lookup(dict_t *, const void *);
+extern dnode_t *dict_lower_bound(dict_t *, const void *);
+extern dnode_t *dict_upper_bound(dict_t *, const void *);
+extern void dict_insert(dict_t *, dnode_t *, const void *);
+extern dnode_t *dict_delete(dict_t *, dnode_t *);
+extern int dict_alloc_insert(dict_t *, const void *, void *);
+extern void dict_delete_free(dict_t *, dnode_t *);
+extern dnode_t *dict_first(dict_t *);
+extern dnode_t *dict_last(dict_t *);
+extern dnode_t *dict_next(dict_t *, dnode_t *);
+extern dnode_t *dict_prev(dict_t *, dnode_t *);
+extern dictcount_t dict_count(dict_t *);
+extern int dict_isempty(dict_t *);
+extern int dict_isfull(dict_t *);
+extern int dict_contains(dict_t *, dnode_t *);
+extern void dict_allow_dupes(dict_t *);
+extern int dnode_is_in_a_dict(dnode_t *);
+extern dnode_t *dnode_create(void *);
+extern dnode_t *dnode_init(dnode_t *, void *);
+extern void dnode_destroy(dnode_t *);
+extern void *dnode_get(dnode_t *);
+extern const void *dnode_getkey(dnode_t *);
+extern void dnode_put(dnode_t *, void *);
+extern void dict_process(dict_t *, void *, dnode_process_t);
+extern void dict_load_begin(dict_load_t *, dict_t *);
+extern void dict_load_next(dict_load_t *, dnode_t *, const void *);
+extern void dict_load_end(dict_load_t *);
+extern void dict_merge(dict_t *, dict_t *);
+
+#if defined(DICT_IMPLEMENTATION) || !defined(KAZLIB_OPAQUE_DEBUG)
+#ifdef KAZLIB_SIDEEFFECT_DEBUG
+#define dict_isfull(D) (SFX_CHECK(D)->dict_nodecount == (D)->dict_maxcount)
+#else
+#define dict_isfull(D) ((D)->dict_nodecount == (D)->dict_maxcount)
+#endif
+#define dict_count(D) ((D)->dict_nodecount)
+#define dict_isempty(D) ((D)->dict_nodecount == 0)
+#define dnode_get(N) ((N)->dict_data)
+#define dnode_getkey(N) ((N)->dict_key)
+#define dnode_put(N, X) ((N)->dict_data = (X))
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/fsck/dqblk_v2.h b/fsck/dqblk_v2.h
new file mode 100644
index 0000000..d12512a
--- /dev/null
+++ b/fsck/dqblk_v2.h
@@ -0,0 +1,31 @@
+/*
+ * Header file for disk format of new quotafile format
+ *
+ * Jan Kara <jack@suse.cz> - sponsored by SuSE CR
+ */
+
+#ifndef __QUOTA_DQBLK_V2_H__
+#define __QUOTA_DQBLK_V2_H__
+
+#include "quotaio_tree.h"
+
+/* Structure for format specific information */
+struct v2_mem_dqinfo {
+	struct qtree_mem_dqinfo dqi_qtree;
+	unsigned int dqi_flags;		/* Flags set in quotafile */
+	unsigned int dqi_used_entries;	/* Number of entries in file -
+					   updated by scan_dquots */
+	unsigned int dqi_data_blocks;	/* Number of data blocks in file -
+					   updated by scan_dquots */
+};
+
+struct v2_mem_dqblk {
+	long long dqb_off;	/* Offset of dquot in file */
+};
+
+struct quotafile_ops;		/* Will be defined later in quotaio.h */
+
+/* Operations above this format */
+extern struct quotafile_ops quotafile_ops_2;
+
+#endif  /* __QUOTA_DQBLK_V2_H__ */
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 56a47be..35df68c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -9,12 +9,12 @@
  * published by the Free Software Foundation.
  */
 #include "fsck.h"
+#include "quotaio.h"
 
 char *tree_mark;
 uint32_t tree_mark_size = 256;
 
-static inline int f2fs_set_main_bitmap(struct f2fs_sb_info *sbi, u32 blk,
-								int type)
+int f2fs_set_main_bitmap(struct f2fs_sb_info *sbi, u32 blk, int type)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct seg_entry *se;
@@ -50,6 +50,13 @@ static inline int f2fs_test_sit_bitmap(struct f2fs_sb_info *sbi, u32 blk)
 	return f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, blk), fsck->sit_area_bitmap);
 }
 
+int f2fs_set_sit_bitmap(struct f2fs_sb_info *sbi, u32 blk)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+
+	return f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, blk), fsck->sit_area_bitmap);
+}
+
 static int add_into_hard_link_list(struct f2fs_sb_info *sbi,
 						u32 nid, u32 link_cnt)
 {
@@ -500,7 +507,9 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		goto err;
 
 	if (ntype == TYPE_INODE) {
+		struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 		fsck_chk_inode_blk(sbi, nid, ftype, node_blk, blk_cnt, &ni);
+		quota_add_inode_usage(fsck->qctx, nid, &node_blk->i);
 	} else {
 		switch (ntype) {
 		case TYPE_DIRECT_NODE:
@@ -622,7 +631,8 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		if (f2fs_test_main_bitmap(sbi, ni->blk_addr) == 0) {
 			f2fs_set_main_bitmap(sbi, ni->blk_addr,
 							CURSEG_WARM_NODE);
-			if (i_links > 1 && ftype != F2FS_FT_ORPHAN) {
+			if (i_links > 1 && ftype != F2FS_FT_ORPHAN &&
+					!is_qf_ino(F2FS_RAW_SUPER(sbi), nid)) {
 				/* First time. Create new hard link node */
 				add_into_hard_link_list(sbi, nid, i_links);
 				fsck->chk.multi_hard_link_files++;
@@ -807,6 +817,11 @@ skip_blkcnt_fix:
 				le32_to_cpu(node_blk->footer.ino),
 				en, (u32)i_blocks);
 
+	if (is_qf_ino(F2FS_RAW_SUPER(sbi), nid))
+		DBG(1, "Quota Inode: 0x%x [%s] i_blocks: %u\n\n",
+				le32_to_cpu(node_blk->footer.ino),
+				en, (u32)i_blocks);
+
 	if (ftype == F2FS_FT_DIR) {
 		DBG(1, "Directory Inode: 0x%x [%s] depth: %d has %d files\n\n",
 				le32_to_cpu(node_blk->footer.ino), en,
@@ -1558,6 +1573,82 @@ int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+int fsck_chk_quota_node(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	enum quota_type qtype;
+	int ret = 0;
+	u32 blk_cnt = 0;
+
+	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++) {
+		if (sb->qf_ino[qtype] == 0)
+			continue;
+		nid_t ino = QUOTA_INO(sb, qtype);
+		struct node_info ni;
+
+		DBG(1, "[%3d] ino [0x%x]\n", qtype, ino);
+		blk_cnt = 1;
+
+		if (c.preen_mode == PREEN_MODE_1 && !c.fix_on) {
+			get_node_info(sbi, ino, &ni);
+			if (!IS_VALID_NID(sbi, ino) ||
+					!IS_VALID_BLK_ADDR(sbi, ni.blk_addr))
+				return -EINVAL;
+		}
+		ret = fsck_chk_node_blk(sbi, NULL, ino,
+				F2FS_FT_REG_FILE, TYPE_INODE, &blk_cnt, NULL);
+		if (ret)
+			ASSERT_MSG("[0x%x] wrong orphan inode", ino);
+	}
+	return ret;
+}
+
+int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	enum quota_type qtype;
+	f2fs_ino_t ino;
+	int ret = 0;
+	int needs_writeout;
+
+	/* Return if quota feature is disabled */
+	if (!fsck->qctx)
+		return 0;
+
+	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++) {
+		ino = sb->qf_ino[qtype];
+		if (!ino)
+			continue;
+
+	        DBG(1, "Checking Quota file ([%3d] ino [0x%x])\n", qtype, ino);
+		needs_writeout = 0;
+		ret = quota_compare_and_update(sbi, qtype, &needs_writeout);
+		if (ret == 0 && needs_writeout == 0) {
+			DBG(1, "OK\n");
+			continue;
+		}
+
+		/* Something is wrong */
+		if (c.fix_on) {
+			DBG(0, "Fixing Quota file ([%3d] ino [0x%x])\n",
+							qtype, ino);
+			f2fs_filesize_update(sbi, ino, 0);
+			ret = quota_write_inode(sbi, qtype);
+			if (!ret) {
+				c.bug_on = 1;
+				DBG(1, "OK\n");
+			} else {
+				ASSERT_MSG("Unable to write quota file");
+			}
+		} else {
+			ASSERT_MSG("Quota file is missing or invalid"
+					" quota file content found.");
+		}
+	}
+	return ret;
+}
+
 int fsck_chk_meta(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -1618,6 +1709,10 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
 	if (fsck_chk_orphan_node(sbi))
 		return -EINVAL;
 
+	/* 5. check quota inode simply */
+	if (fsck_chk_quota_node(sbi))
+		return -EINVAL;
+
 	if (fsck->nat_valid_inode_cnt != le32_to_cpu(cp->valid_inode_count)) {
 		ASSERT_MSG("valid inode does not match: nat_valid_inode_cnt %u,"
 				" valid_inode_count %u",
@@ -2042,6 +2137,10 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 void fsck_free(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+
+	if (fsck->qctx)
+		quota_release_context(&fsck->qctx);
+
 	if (fsck->main_area_bitmap)
 		free(fsck->main_area_bitmap);
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 5628906..7b6ac2b 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -13,6 +13,8 @@
 
 #include "f2fs.h"
 
+struct quota_ctx;
+
 #define FSCK_UNMATCHED_EXTENT		0x00000001
 
 enum {
@@ -85,6 +87,8 @@ struct f2fs_fsck {
 	u32 dentry_depth;
 	struct f2fs_nat_entry *entries;
 	u32 nat_valid_inode_cnt;
+
+	struct quota_ctx *qctx;
 };
 
 #define BLOCK_SZ		4096
@@ -118,6 +122,8 @@ enum seg_type {
 struct selabel_handle;
 
 extern int fsck_chk_orphan_node(struct f2fs_sb_info *);
+extern int fsck_chk_quota_node(struct f2fs_sb_info *);
+extern int fsck_chk_quota_files(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
 		enum FILE_TYPE, enum NODE_TYPE, u32 *,
 		struct child_info *);
@@ -154,6 +160,8 @@ extern void nullify_nat_entry(struct f2fs_sb_info *, u32);
 extern void rewrite_sit_area_bitmap(struct f2fs_sb_info *);
 extern void build_nat_area_bitmap(struct f2fs_sb_info *);
 extern void build_sit_area_bitmap(struct f2fs_sb_info *);
+extern int f2fs_set_main_bitmap(struct f2fs_sb_info *, u32, int);
+extern int f2fs_set_sit_bitmap(struct f2fs_sb_info *, u32);
 extern void fsck_init(struct f2fs_sb_info *);
 extern int fsck_verify(struct f2fs_sb_info *);
 extern void fsck_free(struct f2fs_sb_info *);
@@ -210,6 +218,8 @@ int f2fs_resize(struct f2fs_sb_info *);
 /* sload.c */
 int f2fs_sload(struct f2fs_sb_info *, const char *, const char *,
 		const char *, struct selabel_handle *);
+
+/* segment.c */
 void reserve_new_block(struct f2fs_sb_info *, block_t *,
 					struct f2fs_summary *, int);
 void new_data_block(struct f2fs_sb_info *, void *,
diff --git a/fsck/main.c b/fsck/main.c
index c9411eb..eab213d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -18,6 +18,7 @@
 #include "fsck.h"
 #include <libgen.h>
 #include <ctype.h>
+#include "quotaio.h"
 
 struct f2fs_fsck gfsck;
 
@@ -407,6 +408,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	u32 flag = le32_to_cpu(ckpt->ckpt_flags);
 	u32 blk_cnt;
+	errcode_t ret;
 
 	fsck_init(sbi);
 
@@ -429,8 +431,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 				c.fix_on = 1;
 			break;
 		}
-	} else {
-		/*
+	} else { /*
 		 * we can hit this in 3 situations:
 		 *  1. fsck -f, fix_on has already been set to 1 when
 		 *     parsing options;
@@ -443,12 +444,23 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 		c.fix_on = 1;
 	}
 
-	fsck_chk_orphan_node(sbi);
+	fsck_chk_quota_node(sbi);
 
 	/* Traverse all block recursively from root inode */
 	blk_cnt = 1;
+
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
+		ret = quota_init_context(sbi);
+		if (ret) {
+			ASSERT_MSG("quota_init_context failure: %d", ret);
+			return;
+		}
+	}
+	fsck_chk_orphan_node(sbi);
 	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num,
 			F2FS_FT_DIR, TYPE_INODE, &blk_cnt, NULL);
+	fsck_chk_quota_files(sbi);
+
 	fsck_verify(sbi);
 	fsck_free(sbi);
 }
diff --git a/fsck/mkquota.c b/fsck/mkquota.c
new file mode 100644
index 0000000..aadfae7
--- /dev/null
+++ b/fsck/mkquota.c
@@ -0,0 +1,403 @@
+/*
+ * mkquota.c --- create quota files for a filesystem
+ *
+ * Aditya Kali <adityakali@google.com>
+ * Hyojun Kim <hyojun@google.com> - Ported to f2fs-tools
+ */
+#include "config.h"
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+
+#include "quotaio.h"
+#include "quotaio_v2.h"
+#include "quotaio_tree.h"
+#include "common.h"
+#include "dict.h"
+
+
+/* Needed for architectures where sizeof(int) != sizeof(void *) */
+#define UINT_TO_VOIDPTR(val)  ((void *)(intptr_t)(val))
+#define VOIDPTR_TO_UINT(ptr)  ((unsigned int)(intptr_t)(ptr))
+
+#if DEBUG_QUOTA
+static void print_dquot(const char *desc, struct dquot *dq)
+{
+	if (desc)
+		fprintf(stderr, "%s: ", desc);
+	fprintf(stderr, "%u %lld:%lld:%lld %lld:%lld:%lld\n",
+		dq->dq_id, (long long) dq->dq_dqb.dqb_curspace,
+		(long long) dq->dq_dqb.dqb_bsoftlimit,
+		(long long) dq->dq_dqb.dqb_bhardlimit,
+		(long long) dq->dq_dqb.dqb_curinodes,
+		(long long) dq->dq_dqb.dqb_isoftlimit,
+		(long long) dq->dq_dqb.dqb_ihardlimit);
+}
+#else
+#define print_dquot(...)
+#endif
+
+static void write_dquots(dict_t *dict, struct quota_handle *qh)
+{
+	dnode_t		*n;
+	struct dquot	*dq;
+
+	for (n = dict_first(dict); n; n = dict_next(dict, n)) {
+		dq = dnode_get(n);
+		if (dq) {
+			print_dquot("write", dq);
+			dq->dq_h = qh;
+			update_grace_times(dq);
+			qh->qh_ops->commit_dquot(dq);
+		}
+	}
+}
+
+errcode_t quota_write_inode(struct f2fs_sb_info *sbi, enum quota_type qtype)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	quota_ctx_t qctx = fsck->qctx;
+	struct quota_handle *h = NULL;
+	int retval = 0;
+	dict_t *dict;
+
+	if ((!qctx) || (!sb->qf_ino[qtype]))
+		return 0;
+
+	retval = quota_get_mem(sizeof(struct quota_handle), &h);
+	if (retval) {
+		log_debug("Unable to allocate quota handle");
+		goto out;
+	}
+
+	dict = qctx->quota_dict[qtype];
+	if (dict) {
+		retval = quota_file_create(sbi, h, qtype);
+		if (retval) {
+			log_debug("Cannot initialize io on quotafile");
+		} else {
+			write_dquots(dict, h);
+			quota_file_close(sbi, h, 1);
+		}
+	}
+out:
+	if (h)
+		quota_free_mem(&h);
+	return retval;
+}
+
+/******************************************************************/
+/* Helper functions for computing quota in memory.                */
+/******************************************************************/
+
+static int dict_uint_cmp(const void *a, const void *b)
+{
+	unsigned int	c, d;
+
+	c = VOIDPTR_TO_UINT(a);
+	d = VOIDPTR_TO_UINT(b);
+
+	if (c == d)
+		return 0;
+	else if (c > d)
+		return 1;
+	else
+		return -1;
+}
+
+static inline qid_t get_qid(struct f2fs_inode *inode, enum quota_type qtype)
+{
+	switch (qtype) {
+	case USRQUOTA:
+		return inode->i_uid;
+	case GRPQUOTA:
+		return inode->i_gid;
+	case PRJQUOTA:
+		return inode->i_projid;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static void quota_dnode_free(dnode_t *node, void *UNUSED(context))
+{
+	void *ptr = node ? dnode_get(node) : 0;
+
+	quota_free_mem(&ptr);
+	free(node);
+}
+
+/*
+ * Set up the quota tracking data structures.
+ */
+errcode_t quota_init_context(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	errcode_t err;
+	dict_t	*dict;
+	quota_ctx_t ctx;
+	enum quota_type	qtype;
+
+	err = quota_get_mem(sizeof(struct quota_ctx), &ctx);
+	if (err) {
+		log_debug("Failed to allocate quota context");
+		return err;
+	}
+
+	memset(ctx, 0, sizeof(struct quota_ctx));
+	dict_init(&ctx->linked_inode_dict, DICTCOUNT_T_MAX, dict_uint_cmp);
+	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
+		ctx->quota_file[qtype] = NULL;
+		if (!sb->qf_ino[qtype])
+			continue;
+		err = quota_get_mem(sizeof(dict_t), &dict);
+		if (err) {
+			log_debug("Failed to allocate dictionary");
+			quota_release_context(&ctx);
+			return err;
+		}
+		ctx->quota_dict[qtype] = dict;
+		dict_init(dict, DICTCOUNT_T_MAX, dict_uint_cmp);
+		dict_set_allocator(dict, NULL, quota_dnode_free, NULL);
+	}
+	ctx->sbi = sbi;
+	fsck->qctx = ctx;
+	return 0;
+}
+
+void quota_release_context(quota_ctx_t *qctx)
+{
+	dict_t	*dict;
+	enum quota_type	qtype;
+	quota_ctx_t ctx;
+
+	if (!qctx)
+		return;
+
+	ctx = *qctx;
+	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
+		dict = ctx->quota_dict[qtype];
+		ctx->quota_dict[qtype] = 0;
+		if (dict) {
+			dict_free_nodes(dict);
+			free(dict);
+		}
+	}
+	dict_free_nodes(&ctx->linked_inode_dict);
+	*qctx = NULL;
+	free(ctx);
+}
+
+static struct dquot *get_dq(dict_t *dict, __u32 key)
+{
+	struct dquot	*dq;
+	dnode_t		*n;
+
+	n = dict_lookup(dict, UINT_TO_VOIDPTR(key));
+	if (n)
+		dq = dnode_get(n);
+	else {
+		if (quota_get_mem(sizeof(struct dquot), &dq)) {
+			log_err("Unable to allocate dquot");
+			return NULL;
+		}
+		memset(dq, 0, sizeof(struct dquot));
+		dict_alloc_insert(dict, UINT_TO_VOIDPTR(key), dq);
+		dq->dq_id = key;
+	}
+	return dq;
+}
+
+/*
+ * Called to update the blocks used by a particular inode
+ */
+void quota_data_add(quota_ctx_t qctx, struct f2fs_inode *inode, qsize_t space)
+{
+	struct dquot	*dq;
+	dict_t		*dict;
+	enum quota_type	qtype;
+
+	if (!qctx)
+		return;
+
+	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
+		dict = qctx->quota_dict[qtype];
+		if (dict) {
+			dq = get_dq(dict, get_qid(inode, qtype));
+			if (dq)
+				dq->dq_dqb.dqb_curspace += space;
+		}
+	}
+}
+
+/*
+ * Called to remove some blocks used by a particular inode
+ */
+void quota_data_sub(quota_ctx_t qctx, struct f2fs_inode *inode, qsize_t space)
+{
+	struct dquot	*dq;
+	dict_t		*dict;
+	enum quota_type	qtype;
+
+	if (!qctx)
+		return;
+
+	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
+		dict = qctx->quota_dict[qtype];
+		if (dict) {
+			dq = get_dq(dict, get_qid(inode, qtype));
+			dq->dq_dqb.dqb_curspace -= space;
+		}
+	}
+}
+
+/*
+ * Called to count the files used by an inode's user/group
+ */
+void quota_data_inodes(quota_ctx_t qctx, struct f2fs_inode *inode, int adjust)
+{
+	struct dquot	*dq;
+	dict_t		*dict; enum quota_type	qtype;
+
+	if (!qctx)
+		return;
+
+	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
+		dict = qctx->quota_dict[qtype];
+		if (dict) {
+			dq = get_dq(dict, get_qid(inode, qtype));
+			dq->dq_dqb.dqb_curinodes += adjust;
+		}
+	}
+}
+
+/*
+ * Called from fsck to count quota.
+ */
+void quota_add_inode_usage(quota_ctx_t qctx, f2fs_ino_t ino,
+		struct f2fs_inode* inode)
+{
+	if (qctx) {
+		/* Handle hard linked inodes */
+		if (inode->i_links > 1) {
+			if (dict_lookup(&qctx->linked_inode_dict,
+				UINT_TO_VOIDPTR(ino))) {
+				return;
+			}
+			dict_alloc_insert(&qctx->linked_inode_dict,
+					UINT_TO_VOIDPTR(ino), NULL);
+		}
+
+		qsize_t space = (inode->i_blocks - 1) * BLOCK_SZ;
+		quota_data_add(qctx, inode, space);
+		quota_data_inodes(qctx, inode, +1);
+	}
+}
+
+struct scan_dquots_data {
+	dict_t		*quota_dict;
+	int             update_limits; /* update limits from disk */
+	int		update_usage;
+	int		usage_is_inconsistent;
+};
+
+static int scan_dquots_callback(struct dquot *dquot, void *cb_data)
+{
+	struct scan_dquots_data *scan_data = cb_data;
+	dict_t *quota_dict = scan_data->quota_dict;
+	struct dquot *dq;
+
+	dq = get_dq(quota_dict, dquot->dq_id);
+	dq->dq_id = dquot->dq_id;
+	dq->dq_flags |= DQF_SEEN;
+
+	print_dquot("mem", dq);
+	print_dquot("dsk", dquot);
+	/* Check if there is inconsistency */
+	if (dq->dq_dqb.dqb_curspace != dquot->dq_dqb.dqb_curspace ||
+	    dq->dq_dqb.dqb_curinodes != dquot->dq_dqb.dqb_curinodes) {
+		scan_data->usage_is_inconsistent = 1;
+		log_debug("[QUOTA WARNING] Usage inconsistent for ID %u:"
+			"actual (%lld, %lld) != expected (%lld, %lld)\n",
+				dq->dq_id, (long long) dq->dq_dqb.dqb_curspace,
+				(long long) dq->dq_dqb.dqb_curinodes,
+				(long long) dquot->dq_dqb.dqb_curspace,
+				(long long) dquot->dq_dqb.dqb_curinodes);
+	}
+
+	if (scan_data->update_limits) {
+		dq->dq_dqb.dqb_ihardlimit = dquot->dq_dqb.dqb_ihardlimit;
+		dq->dq_dqb.dqb_isoftlimit = dquot->dq_dqb.dqb_isoftlimit;
+		dq->dq_dqb.dqb_bhardlimit = dquot->dq_dqb.dqb_bhardlimit;
+		dq->dq_dqb.dqb_bsoftlimit = dquot->dq_dqb.dqb_bsoftlimit;
+	}
+
+	if (scan_data->update_usage) {
+		dq->dq_dqb.dqb_curspace = dquot->dq_dqb.dqb_curspace;
+		dq->dq_dqb.dqb_curinodes = dquot->dq_dqb.dqb_curinodes;
+	}
+
+	return 0;
+}
+
+/*
+ * Compares the measured quota in qctx->quota_dict with that in the quota inode
+ * on disk and updates the limits in qctx->quota_dict. 'usage_inconsistent' is
+ * set to 1 if the supplied and on-disk quota usage values are not identical.
+ */
+errcode_t quota_compare_and_update(struct f2fs_sb_info *sbi,
+		enum quota_type qtype, int *usage_inconsistent)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	quota_ctx_t qctx = fsck->qctx;
+	struct quota_handle qh;
+	struct scan_dquots_data scan_data;
+	struct dquot *dq;
+	dnode_t *n;
+	dict_t *dict = qctx->quota_dict[qtype];
+	errcode_t err = 0;
+
+	if (!dict)
+		goto out;
+
+	err = quota_file_open(sbi, &qh, qtype, 0);
+	if (err) {
+		log_debug("Open quota file failed");
+		goto out;
+	}
+
+	scan_data.quota_dict = qctx->quota_dict[qtype];
+	scan_data.update_limits = 1;
+	scan_data.update_usage = 0;
+	scan_data.usage_is_inconsistent = 0;
+	err = qh.qh_ops->scan_dquots(&qh, scan_dquots_callback, &scan_data);
+	if (err) {
+		log_debug("Error scanning dquots");
+		goto out;
+	}
+
+	for (n = dict_first(dict); n; n = dict_next(dict, n)) {
+		dq = dnode_get(n);
+		if (!dq)
+			continue;
+		if ((dq->dq_flags & DQF_SEEN) == 0) {
+			log_debug("[QUOTA WARNING] "
+				"Missing quota entry ID %d\n", dq->dq_id);
+			scan_data.usage_is_inconsistent = 1;
+		}
+	}
+	*usage_inconsistent = scan_data.usage_is_inconsistent;
+
+out:
+	return err;
+}
+
diff --git a/fsck/mount.c b/fsck/mount.c
index 29af3b7..d71e107 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -297,6 +297,9 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)) {
 		MSG(0, "%s", " flexible inline xattr");
 	}
+	if (f & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
+		MSG(0, "%s", " quota ino");
+	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
 					sb->encryption_level);
@@ -739,7 +742,7 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 	nid_t nid;
 	int i;
 
-	if (!(c.func == SLOAD))
+	if (!(c.func == SLOAD || c.func == FSCK))
 		return 0;
 
 	nm_i->nid_bitmap = (char *)calloc(nid_bitmap_size, 1);
@@ -2159,10 +2162,14 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 	if (c.auto_fix || c.preen_mode) {
 		u32 flag = get_cp(ckpt_flags);
 
-		if (flag & CP_FSCK_FLAG)
+		if (flag & CP_FSCK_FLAG ||
+			(exist_qf_ino(sb) && (!(flag & CP_UMOUNT_FLAG) ||
+						flag & CP_ERROR_FLAG))) {
 			c.fix_on = 1;
-		else if (!c.preen_mode)
+		} else if (!c.preen_mode) {
+			print_cp_state(flag);
 			return 1;
+		}
 	}
 
 	c.bug_on = 0;
@@ -2224,7 +2231,7 @@ void f2fs_do_umount(struct f2fs_sb_info *sbi)
 	unsigned int i;
 
 	/* free nm_info */
-	if (c.func == SLOAD)
+	if (c.func == SLOAD || c.func == FSCK)
 		free(nm_i->nid_bitmap);
 	free(nm_i->nat_bitmap);
 	free(sbi->nm_info);
diff --git a/fsck/quotaio.c b/fsck/quotaio.c
new file mode 100644
index 0000000..afadf56
--- /dev/null
+++ b/fsck/quotaio.c
@@ -0,0 +1,221 @@
+/** quotaio.c
+ *
+ * Generic IO operations on quotafiles
+ * Jan Kara <jack@suse.cz> - sponsored by SuSE CR
+ * Aditya Kali <adityakali@google.com> - Ported to e2fsprogs
+ * Hyojun Kim <hyojun@google.com> - Ported to f2fs-tools
+ */
+
+#include "config.h"
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <time.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/file.h>
+#include <assert.h>
+
+#include "common.h"
+#include "quotaio.h"
+
+static const char * const extensions[MAXQUOTAS] = {
+	[USRQUOTA] = "user",
+	[GRPQUOTA] = "group",
+	[PRJQUOTA] = "project",
+};
+
+/* Header in all newer quotafiles */
+struct disk_dqheader {
+	__le32 dqh_magic;
+	__le32 dqh_version;
+} __attribute__ ((packed));
+
+/**
+ * Convert type of quota to written representation
+ */
+const char *quota_type2name(enum quota_type qtype)
+{
+	if (qtype >= MAXQUOTAS)
+		return "unknown";
+	return extensions[qtype];
+}
+
+/*
+ * Set grace time if needed
+ */
+void update_grace_times(struct dquot *q)
+{
+	time_t now;
+
+	time(&now);
+	if (q->dq_dqb.dqb_bsoftlimit && toqb(q->dq_dqb.dqb_curspace) >
+			q->dq_dqb.dqb_bsoftlimit) {
+		if (!q->dq_dqb.dqb_btime)
+			q->dq_dqb.dqb_btime =
+				now + q->dq_h->qh_info.dqi_bgrace;
+	} else {
+		q->dq_dqb.dqb_btime = 0;
+	}
+
+	if (q->dq_dqb.dqb_isoftlimit && q->dq_dqb.dqb_curinodes >
+			q->dq_dqb.dqb_isoftlimit) {
+		if (!q->dq_dqb.dqb_itime)
+				q->dq_dqb.dqb_itime =
+					now + q->dq_h->qh_info.dqi_igrace;
+	} else {
+		q->dq_dqb.dqb_itime = 0;
+	}
+}
+
+/* Functions to read/write quota file. */
+static unsigned int quota_write_nomount(struct quota_file *qf,
+					long offset,
+					void *buf, unsigned int size)
+{
+	unsigned int written;
+
+	written = f2fs_write(qf->sbi, qf->ino, buf, size, offset);
+	if (qf->filesize < offset + written)
+		qf->filesize = offset + written;
+
+	return written;
+}
+
+static unsigned int quota_read_nomount(struct quota_file *qf, long offset,
+		void *buf, unsigned int size)
+{
+	return f2fs_read(qf->sbi, qf->ino, buf, size, offset);
+}
+
+/*
+ * Detect quota format and initialize quota IO
+ */
+errcode_t quota_file_open(struct f2fs_sb_info *sbi, struct quota_handle *h,
+			  enum quota_type qtype, int flags)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	quota_ctx_t qctx = fsck->qctx;
+	f2fs_ino_t qf_ino;
+	errcode_t err = 0;
+	int allocated_handle = 0;
+
+	if (qtype >= MAXQUOTAS)
+		return EINVAL;
+
+	qf_ino = sb->qf_ino[qtype];
+
+	if (!h) {
+		if (qctx->quota_file[qtype]) {
+			h = qctx->quota_file[qtype];
+			(void) quota_file_close(sbi, h, 0);
+		}
+		err = quota_get_mem(sizeof(struct quota_handle), &h);
+		if (err) {
+			log_err("Unable to allocate quota handle");
+			return err;
+		}
+		allocated_handle = 1;
+	}
+
+	h->qh_qf.sbi = sbi;
+	h->qh_qf.ino = qf_ino;
+	h->write = quota_write_nomount;
+	h->read = quota_read_nomount;
+	h->qh_file_flags = flags;
+	h->qh_io_flags = 0;
+	h->qh_type = qtype;
+	h->qh_fmt = QFMT_VFS_V1;
+	memset(&h->qh_info, 0, sizeof(h->qh_info));
+	h->qh_ops = &quotafile_ops_2;
+
+	if (h->qh_ops->check_file &&
+	    (h->qh_ops->check_file(h, qtype) == 0)) {
+		log_err("qh_ops->check_file failed");
+		err = EIO;
+		goto errout;
+	}
+
+	if (h->qh_ops->init_io && (h->qh_ops->init_io(h) < 0)) {
+		log_err("qh_ops->init_io failed");
+		err = EIO;
+		goto errout;
+	}
+	if (allocated_handle)
+		qctx->quota_file[qtype] = h;
+errout:
+	return err;
+}
+
+/*
+ * Create new quotafile of specified format on given filesystem
+ */
+errcode_t quota_file_create(struct f2fs_sb_info *sbi, struct quota_handle *h,
+		enum quota_type qtype)
+{
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	f2fs_ino_t qf_inum = sb->qf_ino[qtype];
+	errcode_t err = 0;
+
+	h->qh_qf.sbi = sbi;
+	h->qh_qf.ino = qf_inum;
+	h->write = quota_write_nomount;
+	h->read = quota_read_nomount;
+
+	log_debug("Creating quota ino=%u, type=%d", qf_inum, qtype);
+	h->qh_io_flags = 0;
+	h->qh_type = qtype;
+	h->qh_fmt = QFMT_VFS_V1;
+	memset(&h->qh_info, 0, sizeof(h->qh_info));
+	h->qh_ops = &quotafile_ops_2;
+
+	if (h->qh_ops->new_io && (h->qh_ops->new_io(h) < 0)) {
+		log_err("qh_ops->new_io failed");
+		err = EIO;
+	}
+
+	return err;
+}
+
+/*
+ * Close quotafile and release handle
+ */
+errcode_t quota_file_close(struct f2fs_sb_info *sbi, struct quota_handle *h,
+		int update_filesize)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	quota_ctx_t qctx = fsck->qctx;
+
+        if (h->qh_io_flags & IOFL_INFODIRTY) {
+		if (h->qh_ops->write_info && h->qh_ops->write_info(h) < 0)
+			return EIO;
+		h->qh_io_flags &= ~IOFL_INFODIRTY;
+	}
+	if (h->qh_ops->end_io && h->qh_ops->end_io(h) < 0)
+		return EIO;
+	if (update_filesize) {
+		f2fs_filesize_update(sbi, h->qh_qf.ino, h->qh_qf.filesize);
+	}
+	if (qctx->quota_file[h->qh_type] == h)
+		quota_free_mem(&qctx->quota_file[h->qh_type]);
+	return 0;
+}
+
+/*
+ * Create empty quota structure
+ */
+struct dquot *get_empty_dquot(void)
+{
+	struct dquot *dquot;
+
+	if (quota_get_memzero(sizeof(struct dquot), &dquot)) {
+		log_err("Failed to allocate dquot");
+		return NULL;
+	}
+
+	dquot->dq_id = -1;
+	return dquot;
+}
diff --git a/fsck/quotaio.h b/fsck/quotaio.h
new file mode 100644
index 0000000..e796eb1
--- /dev/null
+++ b/fsck/quotaio.h
@@ -0,0 +1,255 @@
+/** quotaio.h
+ *
+ * Interface to the quota library.
+ *
+ * The quota library provides interface for creating and updating the quota
+ * files and the ext4 superblock fields. It supports the new VFS_V1 quota
+ * format. The quota library also provides support for keeping track of quotas
+ * in memory.
+ *
+ * Aditya Kali <adityakali@google.com>
+ * Header of IO operations for quota utilities
+ *
+ * Jan Kara <jack@suse.cz>
+ *
+ * Hyojun Kim <hyojun@google.com> - Ported to f2fs-tools
+ */
+
+#ifndef GUARD_QUOTAIO_H
+#define GUARD_QUOTAIO_H
+
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <arpa/inet.h>
+
+#include "dict.h"
+#include "f2fs_fs.h"
+#include "f2fs.h"
+#include "node.h"
+#include "fsck.h"
+
+#include "dqblk_v2.h"
+
+typedef int64_t qsize_t;	/* Type in which we store size limitations */
+typedef int32_t f2fs_ino_t;
+typedef int errcode_t;
+
+enum quota_type {
+	USRQUOTA = 0,
+	GRPQUOTA = 1,
+	PRJQUOTA = 2,
+	MAXQUOTAS = 3,
+};
+
+#if MAXQUOTAS > 32
+#error "cannot have more than 32 quota types to fit in qtype_bits"
+#endif
+
+
+#define QUOTA_USR_BIT (1 << USRQUOTA)
+#define QUOTA_GRP_BIT (1 << GRPQUOTA)
+#define QUOTA_PRJ_BIT (1 << PRJQUOTA)
+#define QUOTA_ALL_BIT (QUOTA_USR_BIT | QUOTA_GRP_BIT | QUOTA_PRJ_BIT)
+
+typedef struct quota_ctx *quota_ctx_t;
+
+struct quota_ctx {
+	struct f2fs_sb_info *sbi;
+	struct dict_t *quota_dict[MAXQUOTAS];
+	struct quota_handle *quota_file[MAXQUOTAS];
+	struct dict_t linked_inode_dict;
+};
+
+/*
+ * Definitions of magics and versions of current quota files
+ */
+#define INITQMAGICS {\
+	0xd9c01f11,	/* USRQUOTA */\
+	0xd9c01927,	/* GRPQUOTA */\
+	0xd9c03f14	/* PRJQUOTA */\
+}
+
+/* Size of blocks in which are counted size limits in generic utility parts */
+#define QUOTABLOCK_BITS 10
+#define QUOTABLOCK_SIZE (1 << QUOTABLOCK_BITS)
+#define toqb(x) (((x) + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS)
+
+/* Quota format type IDs */
+#define	QFMT_VFS_OLD 1
+#define	QFMT_VFS_V0 2
+#define	QFMT_VFS_V1 4
+
+/*
+ * The following constants define the default amount of time given a user
+ * before the soft limits are treated as hard limits (usually resulting
+ * in an allocation failure). The timer is started when the user crosses
+ * their soft limit, it is reset when they go below their soft limit.
+ */
+#define MAX_IQ_TIME  604800	/* (7*24*60*60) 1 week */
+#define MAX_DQ_TIME  604800	/* (7*24*60*60) 1 week */
+
+#define IOFL_INFODIRTY	0x01	/* Did info change? */
+
+struct quotafile_ops;
+
+/* Generic information about quotafile */
+struct util_dqinfo {
+	time_t dqi_bgrace;	/* Block grace time for given quotafile */
+	time_t dqi_igrace;	/* Inode grace time for given quotafile */
+	union {
+		struct v2_mem_dqinfo v2_mdqi;
+	} u;			/* Format specific info about quotafile */
+};
+
+struct quota_file {
+	struct f2fs_sb_info *sbi;
+	f2fs_ino_t ino;
+	int64_t filesize;
+};
+
+/* Structure for one opened quota file */
+struct quota_handle {
+	enum quota_type qh_type;	/* Type of quotafile */
+	int qh_fmt;		/* Quotafile format */
+	int qh_file_flags;
+	int qh_io_flags;	/* IO flags for file */
+	struct quota_file qh_qf;
+	unsigned int (*read)(struct quota_file *qf, long offset,
+			 void *buf, unsigned int size);
+	unsigned int (*write)(struct quota_file *qf, long offset,
+			  void *buf, unsigned int size);
+	struct quotafile_ops *qh_ops;	/* Operations on quotafile */
+	struct util_dqinfo qh_info;	/* Generic quotafile info */
+};
+
+/* Utility quota block */
+struct util_dqblk {
+	qsize_t dqb_ihardlimit;
+	qsize_t dqb_isoftlimit;
+	qsize_t dqb_curinodes;
+	qsize_t dqb_bhardlimit;
+	qsize_t dqb_bsoftlimit;
+	qsize_t dqb_curspace;
+	time_t dqb_btime;
+	time_t dqb_itime;
+	union {
+		struct v2_mem_dqblk v2_mdqb;
+	} u;			/* Format specific dquot information */
+};
+
+/* Structure for one loaded quota */
+struct dquot {
+	struct dquot *dq_next;	/* Pointer to next dquot in the list */
+	qid_t dq_id;		/* ID dquot belongs to */
+	int dq_flags;		/* Some flags for utils */
+	struct quota_handle *dq_h;	/* Handle of quotafile for this dquot */
+	struct util_dqblk dq_dqb;	/* Parsed data of dquot */
+};
+
+#define DQF_SEEN	0x0001
+
+/* Structure of quotafile operations */
+struct quotafile_ops {
+	/* Check whether quotafile is in our format */
+	int (*check_file) (struct quota_handle *h, int type);
+	/* Open quotafile */
+	int (*init_io) (struct quota_handle *h);
+	/* Create new quotafile */
+	int (*new_io) (struct quota_handle *h);
+	/* Write all changes and close quotafile */
+	int (*end_io) (struct quota_handle *h);
+	/* Write info about quotafile */
+	int (*write_info) (struct quota_handle *h);
+	/* Read dquot into memory */
+	struct dquot *(*read_dquot) (struct quota_handle *h, qid_t id);
+	/* Write given dquot to disk */
+	int (*commit_dquot) (struct dquot *dquot);
+	/* Scan quotafile and call callback on every structure */
+	int (*scan_dquots) (struct quota_handle *h,
+			    int (*process_dquot) (struct dquot *dquot,
+						  void *data),
+			    void *data);
+	/* Function to print format specific file information */
+	int (*report) (struct quota_handle *h, int verbose);
+};
+
+#ifdef __CHECKER__
+# ifndef __bitwise
+#  define __bitwise             __attribute__((bitwise))
+# endif
+#define __force                 __attribute__((force))
+#else
+# ifndef __bitwise
+#  define __bitwise
+# endif
+#define __force
+#endif
+
+#define be32_to_cpu(n) ntohl(n)
+
+/* Open existing quotafile of given type (and verify its format) on given
+ * filesystem. */
+errcode_t quota_file_open(struct f2fs_sb_info *sbi, struct quota_handle *h,
+			  enum quota_type qtype, int flags);
+
+/* Create new quotafile of specified format on given filesystem */
+errcode_t quota_file_create(struct f2fs_sb_info *sbi, struct quota_handle *h,
+		enum quota_type qtype);
+
+/* Close quotafile */
+errcode_t quota_file_close(struct f2fs_sb_info *sbi, struct quota_handle *h,
+		int update_filesize);
+
+/* Get empty quota structure */
+struct dquot *get_empty_dquot(void);
+const char *quota_type2name(enum quota_type qtype);
+void update_grace_times(struct dquot *q);
+
+/* In mkquota.c */
+errcode_t quota_init_context(struct f2fs_sb_info *sbi);
+void quota_data_inodes(quota_ctx_t qctx, struct f2fs_inode *inode, int adjust);
+void quota_data_add(quota_ctx_t qctx, struct f2fs_inode *inode, qsize_t space);
+void quota_data_sub(quota_ctx_t qctx, struct f2fs_inode *inode, qsize_t space);
+errcode_t quota_write_inode(struct f2fs_sb_info *sbi, enum quota_type qtype);
+void quota_add_inode_usage(quota_ctx_t qctx, f2fs_ino_t ino,
+		struct f2fs_inode* inode);
+void quota_release_context(quota_ctx_t *qctx);
+errcode_t quota_compare_and_update(struct f2fs_sb_info *sbi,
+		enum quota_type qtype, int *usage_inconsistent);
+
+static inline errcode_t quota_get_mem(unsigned long size, void *ptr)
+{
+        void *pp;
+
+        pp = malloc(size);
+        if (!pp)
+                return -1;
+        memcpy(ptr, &pp, sizeof (pp));
+        return 0;
+}
+
+static inline errcode_t quota_get_memzero(unsigned long size, void *ptr)
+{
+        void *pp;
+
+        pp = malloc(size);
+        if (!pp)
+                return -1;
+        memset(pp, 0, size);
+        memcpy(ptr, &pp, sizeof(pp));
+        return 0;
+}
+
+static inline errcode_t quota_free_mem(void *ptr)
+{
+        void *p;
+
+        memcpy(&p, ptr, sizeof(p));
+        free(p);
+        p = 0;
+        memcpy(ptr, &p, sizeof(p));
+        return 0;
+}
+
+#endif /* GUARD_QUOTAIO_H */
diff --git a/fsck/quotaio_tree.c b/fsck/quotaio_tree.c
new file mode 100644
index 0000000..5aef228
--- /dev/null
+++ b/fsck/quotaio_tree.c
@@ -0,0 +1,679 @@
+/*
+ * Implementation of new quotafile format
+ *
+ * Jan Kara <jack@suse.cz> - sponsored by SuSE CR
+ * Hyojun Kim <hyojun@google.com> - Ported to f2fs-tools
+ */
+
+#include "config.h"
+#include <sys/types.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "common.h"
+#include "quotaio_tree.h"
+#include "quotaio.h"
+
+typedef char *dqbuf_t;
+
+#define freedqbuf(buf)		quota_free_mem(&buf)
+
+static inline dqbuf_t getdqbuf(void)
+{
+	dqbuf_t buf;
+	if (quota_get_memzero(QT_BLKSIZE, &buf)) {
+		log_err("Failed to allocate dqbuf");
+		return NULL;
+	}
+
+	return buf;
+}
+
+/* Is given dquot empty? */
+int qtree_entry_unused(struct qtree_mem_dqinfo *info, char *disk)
+{
+	unsigned int i;
+
+	for (i = 0; i < info->dqi_entry_size; i++)
+		if (disk[i])
+			return 0;
+	return 1;
+}
+
+int qtree_dqstr_in_blk(struct qtree_mem_dqinfo *info)
+{
+	return (QT_BLKSIZE - sizeof(struct qt_disk_dqdbheader)) /
+		info->dqi_entry_size;
+}
+
+static int get_index(qid_t id, int depth)
+{
+	return (id >> ((QT_TREEDEPTH - depth - 1) * 8)) & 0xff;
+}
+
+static inline void mark_quotafile_info_dirty(struct quota_handle *h)
+{
+	h->qh_io_flags |= IOFL_INFODIRTY;
+}
+
+/* Read given block */
+static void read_blk(struct quota_handle *h, unsigned int blk, dqbuf_t buf)
+{
+	int err;
+
+	err = h->read(&h->qh_qf, blk << QT_BLKSIZE_BITS, buf,
+			QT_BLKSIZE);
+	if (err < 0)
+		log_err("Cannot read block %u: %s", blk, strerror(errno));
+	else if (err != QT_BLKSIZE)
+		memset(buf + err, 0, QT_BLKSIZE - err);
+}
+
+/* Write block */
+static int write_blk(struct quota_handle *h, unsigned int blk, dqbuf_t buf)
+{
+	int err;
+
+	err = h->write(&h->qh_qf, blk << QT_BLKSIZE_BITS, buf,
+			QT_BLKSIZE);
+	if (err < 0 && errno != ENOSPC)
+		log_err("Cannot write block (%u): %s", blk, strerror(errno));
+	if (err != QT_BLKSIZE)
+		return -ENOSPC;
+	return 0;
+}
+
+/* Get free block in file (either from free list or create new one) */
+static int get_free_dqblk(struct quota_handle *h)
+{
+	dqbuf_t buf = getdqbuf();
+	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
+	struct qtree_mem_dqinfo *info = &h->qh_info.u.v2_mdqi.dqi_qtree;
+	int blk;
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (info->dqi_free_blk) {
+		blk = info->dqi_free_blk;
+		read_blk(h, blk, buf);
+		info->dqi_free_blk = le32_to_cpu(dh->dqdh_next_free);
+	} else {
+		memset(buf, 0, QT_BLKSIZE);
+		/* Assure block allocation... */
+		if (write_blk(h, info->dqi_blocks, buf) < 0) {
+			freedqbuf(buf);
+			log_err("Cannot allocate new quota block "
+				"(out of disk space).");
+			return -ENOSPC;
+		}
+		blk = info->dqi_blocks++;
+	}
+	mark_quotafile_info_dirty(h);
+	freedqbuf(buf);
+	return blk;
+}
+
+/* Put given block to free list */
+static void put_free_dqblk(struct quota_handle *h, dqbuf_t buf,
+			   unsigned int blk)
+{
+	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
+	struct qtree_mem_dqinfo *info = &h->qh_info.u.v2_mdqi.dqi_qtree;
+
+	dh->dqdh_next_free = cpu_to_le32(info->dqi_free_blk);
+	dh->dqdh_prev_free = cpu_to_le32(0);
+	dh->dqdh_entries = cpu_to_le16(0);
+	info->dqi_free_blk = blk;
+	mark_quotafile_info_dirty(h);
+	write_blk(h, blk, buf);
+}
+
+/* Remove given block from the list of blocks with free entries */
+static void remove_free_dqentry(struct quota_handle *h, dqbuf_t buf,
+				unsigned int blk)
+{
+	dqbuf_t tmpbuf = getdqbuf();
+	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
+	unsigned int nextblk = le32_to_cpu(dh->dqdh_next_free), prevblk =
+		le32_to_cpu(dh->dqdh_prev_free);
+
+	if (!tmpbuf)
+		return;
+
+	if (nextblk) {
+		read_blk(h, nextblk, tmpbuf);
+		((struct qt_disk_dqdbheader *)tmpbuf)->dqdh_prev_free =
+				dh->dqdh_prev_free;
+		write_blk(h, nextblk, tmpbuf);
+	}
+	if (prevblk) {
+		read_blk(h, prevblk, tmpbuf);
+		((struct qt_disk_dqdbheader *)tmpbuf)->dqdh_next_free =
+				dh->dqdh_next_free;
+		write_blk(h, prevblk, tmpbuf);
+	} else {
+		h->qh_info.u.v2_mdqi.dqi_qtree.dqi_free_entry = nextblk;
+		mark_quotafile_info_dirty(h);
+	}
+	freedqbuf(tmpbuf);
+	dh->dqdh_next_free = dh->dqdh_prev_free = cpu_to_le32(0);
+	write_blk(h, blk, buf);	/* No matter whether write succeeds
+				 * block is out of list */
+}
+
+/* Insert given block to the beginning of list with free entries */
+static void insert_free_dqentry(struct quota_handle *h, dqbuf_t buf,
+				unsigned int blk)
+{
+	dqbuf_t tmpbuf = getdqbuf();
+	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
+	struct qtree_mem_dqinfo *info = &h->qh_info.u.v2_mdqi.dqi_qtree;
+
+	if (!tmpbuf)
+		return;
+
+	dh->dqdh_next_free = cpu_to_le32(info->dqi_free_entry);
+	dh->dqdh_prev_free = cpu_to_le32(0);
+	write_blk(h, blk, buf);
+	if (info->dqi_free_entry) {
+		read_blk(h, info->dqi_free_entry, tmpbuf);
+		((struct qt_disk_dqdbheader *)tmpbuf)->dqdh_prev_free =
+				cpu_to_le32(blk);
+		write_blk(h, info->dqi_free_entry, tmpbuf);
+	}
+	freedqbuf(tmpbuf);
+	info->dqi_free_entry = blk;
+	mark_quotafile_info_dirty(h);
+}
+
+/* Find space for dquot */
+static unsigned int find_free_dqentry(struct quota_handle *h,
+				      struct dquot *dquot, int *err)
+{
+	int blk, i;
+	struct qt_disk_dqdbheader *dh;
+	struct qtree_mem_dqinfo *info = &h->qh_info.u.v2_mdqi.dqi_qtree;
+	char *ddquot;
+	dqbuf_t buf;
+
+	*err = 0;
+	buf = getdqbuf();
+	if (!buf) {
+		*err = -ENOMEM;
+		return 0;
+	}
+
+	dh = (struct qt_disk_dqdbheader *)buf;
+	if (info->dqi_free_entry) {
+		blk = info->dqi_free_entry;
+		read_blk(h, blk, buf);
+	} else {
+		blk = get_free_dqblk(h);
+		if (blk < 0) {
+			freedqbuf(buf);
+			*err = blk;
+			return 0;
+		}
+		memset(buf, 0, QT_BLKSIZE);
+		info->dqi_free_entry = blk;
+		mark_quotafile_info_dirty(h);
+	}
+
+	/* Block will be full? */
+	if (le16_to_cpu(dh->dqdh_entries) + 1 >=
+	    qtree_dqstr_in_blk(info))
+		remove_free_dqentry(h, buf, blk);
+
+	dh->dqdh_entries =
+		cpu_to_le16(le16_to_cpu(dh->dqdh_entries) + 1);
+	/* Find free structure in block */
+	ddquot = buf + sizeof(struct qt_disk_dqdbheader);
+	for (i = 0;
+	     i < qtree_dqstr_in_blk(info) && !qtree_entry_unused(info, ddquot);
+	     i++)
+		ddquot += info->dqi_entry_size;
+
+	if (i == qtree_dqstr_in_blk(info))
+		log_err("find_free_dqentry(): Data block full unexpectedly.");
+
+	write_blk(h, blk, buf);
+	dquot->dq_dqb.u.v2_mdqb.dqb_off =
+		(blk << QT_BLKSIZE_BITS) + sizeof(struct qt_disk_dqdbheader) +
+		i * info->dqi_entry_size;
+	freedqbuf(buf);
+	return blk;
+}
+
+/* Insert reference to structure into the trie */
+static int do_insert_tree(struct quota_handle *h, struct dquot *dquot,
+			  unsigned int * treeblk, int depth)
+{
+	dqbuf_t buf;
+	int newson = 0, newact = 0;
+	__le32 *ref;
+	unsigned int newblk;
+	int ret = 0;
+
+	log_debug("inserting in tree: treeblk=%u, depth=%d", *treeblk, depth);
+	buf = getdqbuf();
+	if (!buf)
+		return -ENOMEM;
+
+	if (!*treeblk) {
+		ret = get_free_dqblk(h);
+		if (ret < 0)
+			goto out_buf;
+		*treeblk = ret;
+		memset(buf, 0, QT_BLKSIZE);
+		newact = 1;
+	} else {
+		read_blk(h, *treeblk, buf);
+	}
+
+	ref = (__le32 *) buf;
+	newblk = le32_to_cpu(ref[get_index(dquot->dq_id, depth)]);
+	if (!newblk)
+		newson = 1;
+	if (depth == QT_TREEDEPTH - 1) {
+		if (newblk)
+			log_err("Inserting already present quota entry "
+				"(block %u).",
+				ref[get_index(dquot->dq_id, depth)]);
+		newblk = find_free_dqentry(h, dquot, &ret);
+	} else {
+		ret = do_insert_tree(h, dquot, &newblk, depth + 1);
+	}
+
+	if (newson && ret >= 0) {
+		ref[get_index(dquot->dq_id, depth)] =
+			cpu_to_le32(newblk);
+		write_blk(h, *treeblk, buf);
+	} else if (newact && ret < 0) {
+		put_free_dqblk(h, buf, *treeblk);
+	}
+
+out_buf:
+	freedqbuf(buf);
+	return ret;
+}
+
+/* Wrapper for inserting quota structure into tree */
+static void dq_insert_tree(struct quota_handle *h, struct dquot *dquot)
+{
+	unsigned int tmp = QT_TREEOFF;
+
+	if (do_insert_tree(h, dquot, &tmp, 0) < 0)
+		log_err("Cannot write quota (id %u): %s",
+			(unsigned int) dquot->dq_id, strerror(errno));
+}
+
+/* Write dquot to file */
+void qtree_write_dquot(struct dquot *dquot)
+{
+	errcode_t retval;
+	unsigned int ret;
+	char *ddquot;
+	struct quota_handle *h = dquot->dq_h;
+	struct qtree_mem_dqinfo *info =
+			&dquot->dq_h->qh_info.u.v2_mdqi.dqi_qtree;
+
+
+	log_debug("writing ddquot 1: off=%llu, info->dqi_entry_size=%u",
+			dquot->dq_dqb.u.v2_mdqb.dqb_off,
+			info->dqi_entry_size);
+	retval = quota_get_mem(info->dqi_entry_size, &ddquot);
+	if (retval) {
+		errno = ENOMEM;
+		log_err("Quota write failed (id %u): %s",
+			(unsigned int)dquot->dq_id, strerror(errno));
+		return;
+	}
+	memset(ddquot, 0, info->dqi_entry_size);
+
+	if (!dquot->dq_dqb.u.v2_mdqb.dqb_off) {
+		dq_insert_tree(dquot->dq_h, dquot);
+	}
+	info->dqi_ops->mem2disk_dqblk(ddquot, dquot);
+	log_debug("writing ddquot 2: off=%llu, info->dqi_entry_size=%u",
+			dquot->dq_dqb.u.v2_mdqb.dqb_off,
+			info->dqi_entry_size);
+	ret = h->write(&h->qh_qf, dquot->dq_dqb.u.v2_mdqb.dqb_off, ddquot,
+			info->dqi_entry_size);
+
+	if (ret != info->dqi_entry_size) {
+		if (ret > 0)
+			errno = ENOSPC;
+		log_err("Quota write failed (id %u): %s",
+			(unsigned int)dquot->dq_id, strerror(errno));
+	}
+	quota_free_mem(&ddquot);
+}
+
+/* Free dquot entry in data block */
+static void free_dqentry(struct quota_handle *h, struct dquot *dquot,
+			 unsigned int blk)
+{
+	struct qt_disk_dqdbheader *dh;
+	struct qtree_mem_dqinfo *info = &h->qh_info.u.v2_mdqi.dqi_qtree;
+	dqbuf_t buf = getdqbuf();
+
+	if (!buf)
+		return;
+
+	if (dquot->dq_dqb.u.v2_mdqb.dqb_off >> QT_BLKSIZE_BITS != blk)
+		log_err("Quota structure has offset to other block (%u) "
+			"than it should (%u).", blk,
+			  (unsigned int) (dquot->dq_dqb.u.v2_mdqb.dqb_off >>
+				  QT_BLKSIZE_BITS));
+
+	read_blk(h, blk, buf);
+	dh = (struct qt_disk_dqdbheader *)buf;
+	dh->dqdh_entries =
+		cpu_to_le16(le16_to_cpu(dh->dqdh_entries) - 1);
+
+	if (!le16_to_cpu(dh->dqdh_entries)) {	/* Block got free? */
+		remove_free_dqentry(h, buf, blk);
+		put_free_dqblk(h, buf, blk);
+	} else {
+		memset(buf + (dquot->dq_dqb.u.v2_mdqb.dqb_off &
+			      ((1 << QT_BLKSIZE_BITS) - 1)),
+		       0, info->dqi_entry_size);
+
+		/* First free entry? */
+		if (le16_to_cpu(dh->dqdh_entries) ==
+				qtree_dqstr_in_blk(info) - 1)
+			/* This will also write data block */
+			insert_free_dqentry(h, buf, blk);
+		else
+			write_blk(h, blk, buf);
+	}
+	dquot->dq_dqb.u.v2_mdqb.dqb_off = 0;
+	freedqbuf(buf);
+}
+
+/* Remove reference to dquot from tree */
+static void remove_tree(struct quota_handle *h, struct dquot *dquot,
+			unsigned int * blk, int depth)
+{
+	dqbuf_t buf = getdqbuf();
+	unsigned int newblk;
+	__le32 *ref = (__le32 *) buf;
+
+	if (!buf)
+		return;
+
+	read_blk(h, *blk, buf);
+	newblk = le32_to_cpu(ref[get_index(dquot->dq_id, depth)]);
+	if (depth == QT_TREEDEPTH - 1) {
+		free_dqentry(h, dquot, newblk);
+		newblk = 0;
+	} else {
+		remove_tree(h, dquot, &newblk, depth + 1);
+	}
+
+	if (!newblk) {
+		int i;
+
+		ref[get_index(dquot->dq_id, depth)] = cpu_to_le32(0);
+
+		/* Block got empty? */
+		for (i = 0; i < QT_BLKSIZE && !buf[i]; i++);
+
+		/* Don't put the root block into the free block list */
+		if (i == QT_BLKSIZE && *blk != QT_TREEOFF) {
+			put_free_dqblk(h, buf, *blk);
+			*blk = 0;
+		} else {
+			write_blk(h, *blk, buf);
+		}
+	}
+	freedqbuf(buf);
+}
+
+/* Delete dquot from tree */
+void qtree_delete_dquot(struct dquot *dquot)
+{
+	unsigned int tmp = QT_TREEOFF;
+
+	if (!dquot->dq_dqb.u.v2_mdqb.dqb_off)	/* Even not allocated? */
+		return;
+	remove_tree(dquot->dq_h, dquot, &tmp, 0);
+}
+
+/* Find entry in block */
+static long find_block_dqentry(struct quota_handle *h,
+				      struct dquot *dquot, unsigned int blk)
+{
+	struct qtree_mem_dqinfo *info = &h->qh_info.u.v2_mdqi.dqi_qtree;
+	dqbuf_t buf = getdqbuf();
+	int i;
+	char *ddquot = buf + sizeof(struct qt_disk_dqdbheader);
+
+	if (!buf)
+		return -ENOMEM;
+
+	read_blk(h, blk, buf);
+	for (i = 0;
+	     i < qtree_dqstr_in_blk(info) && !info->dqi_ops->is_id(ddquot, dquot);
+	     i++)
+		ddquot += info->dqi_entry_size;
+
+	if (i == qtree_dqstr_in_blk(info))
+		log_err("Quota for id %u referenced but not present.",
+			dquot->dq_id);
+	freedqbuf(buf);
+	return (blk << QT_BLKSIZE_BITS) + sizeof(struct qt_disk_dqdbheader) +
+		i * info->dqi_entry_size;
+}
+
+/* Find entry for given id in the tree */
+static long find_tree_dqentry(struct quota_handle *h,
+				     struct dquot *dquot,
+				     unsigned int blk, int depth)
+{
+	dqbuf_t buf = getdqbuf();
+	long ret = 0;
+	__le32 *ref = (__le32 *) buf;
+
+	if (!buf)
+		return -ENOMEM;
+
+	read_blk(h, blk, buf);
+	ret = 0;
+	blk = le32_to_cpu(ref[get_index(dquot->dq_id, depth)]);
+	if (!blk)	/* No reference? */
+		goto out_buf;
+	if (depth < QT_TREEDEPTH - 1)
+		ret = find_tree_dqentry(h, dquot, blk, depth + 1);
+	else
+		ret = find_block_dqentry(h, dquot, blk);
+out_buf:
+	freedqbuf(buf);
+	return ret;
+}
+
+/* Find entry for given id in the tree - wrapper function */
+static inline long find_dqentry(struct quota_handle *h,
+				       struct dquot *dquot)
+{
+	return find_tree_dqentry(h, dquot, QT_TREEOFF, 0);
+}
+
+/*
+ *  Read dquot from disk.
+ */
+struct dquot *qtree_read_dquot(struct quota_handle *h, qid_t id)
+{
+	struct qtree_mem_dqinfo *info = &h->qh_info.u.v2_mdqi.dqi_qtree;
+	long offset;
+	unsigned int ret;
+	char *ddquot;
+	struct dquot *dquot = get_empty_dquot();
+
+	if (!dquot)
+		return NULL;
+	if (quota_get_mem(info->dqi_entry_size, &ddquot)) {
+		quota_free_mem(&dquot);
+		return NULL;
+	}
+
+	dquot->dq_id = id;
+	dquot->dq_h = h;
+	dquot->dq_dqb.u.v2_mdqb.dqb_off = 0;
+	memset(&dquot->dq_dqb, 0, sizeof(struct util_dqblk));
+
+	offset = find_dqentry(h, dquot);
+	if (offset > 0) {
+		dquot->dq_dqb.u.v2_mdqb.dqb_off = offset;
+		ret = h->read(&h->qh_qf, offset, ddquot,
+			info->dqi_entry_size);
+		if (ret != info->dqi_entry_size) {
+			if (ret > 0)
+				errno = EIO;
+			log_err("Cannot read quota structure for id %u: %s",
+				dquot->dq_id, strerror(errno));
+		}
+		info->dqi_ops->disk2mem_dqblk(dquot, ddquot);
+	}
+	quota_free_mem(&ddquot);
+	return dquot;
+}
+
+/*
+ * Scan all dquots in file and call callback on each
+ */
+#define set_bit(bmp, ind) ((bmp)[(ind) >> 3] |= (1 << ((ind) & 7)))
+#define get_bit(bmp, ind) ((bmp)[(ind) >> 3] & (1 << ((ind) & 7)))
+
+static int report_block(struct dquot *dquot, unsigned int blk, char *bitmap,
+			int (*process_dquot) (struct dquot *, void *),
+			void *data)
+{
+	struct qtree_mem_dqinfo *info =
+			&dquot->dq_h->qh_info.u.v2_mdqi.dqi_qtree;
+	dqbuf_t buf = getdqbuf();
+	struct qt_disk_dqdbheader *dh;
+	char *ddata;
+	int entries, i;
+
+	if (!buf)
+		return 0;
+
+	set_bit(bitmap, blk);
+	read_blk(dquot->dq_h, blk, buf);
+	dh = (struct qt_disk_dqdbheader *)buf;
+	ddata = buf + sizeof(struct qt_disk_dqdbheader);
+	entries = le16_to_cpu(dh->dqdh_entries);
+	for (i = 0; i < qtree_dqstr_in_blk(info);
+			i++, ddata += info->dqi_entry_size)
+		if (!qtree_entry_unused(info, ddata)) {
+			dquot->dq_dqb.u.v2_mdqb.dqb_off =
+				(blk << QT_BLKSIZE_BITS) +
+				sizeof(struct qt_disk_dqdbheader) +
+				i * info->dqi_entry_size;
+			info->dqi_ops->disk2mem_dqblk(dquot, ddata);
+			if (process_dquot(dquot, data) < 0)
+				break;
+		}
+	freedqbuf(buf);
+	return entries;
+}
+
+static int check_reference(struct quota_handle *h, unsigned int blk)
+{
+	if (blk >= h->qh_info.u.v2_mdqi.dqi_qtree.dqi_blocks) {
+		log_err("Illegal reference (%u >= %u) in %s quota file. "
+			"Quota file is probably corrupted.\n"
+			"Please run fsck (8) to fix it.",
+			blk,
+			h->qh_info.u.v2_mdqi.dqi_qtree.dqi_blocks,
+			quota_type2name(h->qh_type));
+		return -1;
+	}
+	return 0;
+}
+
+/* Return 0 for successful run */
+static int report_tree(struct dquot *dquot, unsigned int blk, int depth,
+		       char *bitmap, int *entries,
+		       int (*process_dquot) (struct dquot *, void *),
+		       void *data)
+{
+	int i;
+	dqbuf_t buf = getdqbuf();
+	__le32 *ref = (__le32 *) buf;
+
+	if (!buf)
+		return -1;
+
+	read_blk(dquot->dq_h, blk, buf);
+	for (i = 0; i < QT_BLKSIZE >> 2; i++) {
+		blk = le32_to_cpu(ref[i]);
+		if (blk == 0)
+			continue;
+
+		if (check_reference(dquot->dq_h, blk))
+			break;
+
+		if (depth == QT_TREEDEPTH - 1) {
+			if (!get_bit(bitmap, blk))
+				*entries += report_block(dquot, blk, bitmap,
+							process_dquot, data);
+		} else {
+			if (report_tree(dquot, blk, depth + 1, bitmap, entries,
+						process_dquot, data))
+				break;
+		}
+	}
+	freedqbuf(buf);
+	return (i < QT_BLKSIZE >> 2) ? -1 : 0;
+}
+
+static unsigned int find_set_bits(char *bmp, int blocks)
+{
+	unsigned int	used = 0;
+	int		i;
+
+	for (i = 0; i < blocks; i++)
+		if (get_bit(bmp, i))
+			used++;
+	return used;
+}
+
+int qtree_scan_dquots(struct quota_handle *h,
+		      int (*process_dquot) (struct dquot *, void *),
+		      void *data)
+{
+	struct v2_mem_dqinfo *v2info = &h->qh_info.u.v2_mdqi;
+	struct qtree_mem_dqinfo *info = &v2info->dqi_qtree;
+	struct dquot *dquot = get_empty_dquot();
+	char *bitmap = NULL;
+	int ret = -1;
+	int entries = 0;
+
+	if (!dquot)
+		return -1;
+
+	dquot->dq_h = h;
+	if (quota_get_memzero((info->dqi_blocks + 7) >> 3, &bitmap))
+		goto out;
+	if (report_tree(dquot, QT_TREEOFF, 0, bitmap, &entries, process_dquot,
+				data))
+		goto out;
+
+	v2info->dqi_used_entries = entries;
+	v2info->dqi_data_blocks = find_set_bits(bitmap, info->dqi_blocks);
+	ret = 0;
+
+out:
+	if (bitmap)
+		quota_free_mem(&bitmap);
+	if (dquot)
+		quota_free_mem(&dquot);
+
+	return ret;
+}
diff --git a/fsck/quotaio_tree.h b/fsck/quotaio_tree.h
new file mode 100644
index 0000000..4ca2d7f
--- /dev/null
+++ b/fsck/quotaio_tree.h
@@ -0,0 +1,66 @@
+/*
+ * Definitions of structures for vfsv0 quota format
+ */
+
+#ifndef _LINUX_QUOTA_TREE_H
+#define _LINUX_QUOTA_TREE_H
+
+#include <inttypes.h>
+#include <linux/types.h>
+#include <sys/types.h>
+
+typedef __u32 qid_t;        /* Type in which we store ids in memory */
+
+#define QT_TREEOFF	1	/* Offset of tree in file in blocks */
+#define QT_TREEDEPTH	4	/* Depth of quota tree */
+#define QT_BLKSIZE_BITS	10
+#define QT_BLKSIZE (1 << QT_BLKSIZE_BITS)	/* Size of block with quota
+						 * structures */
+
+/*
+ *  Structure of header of block with quota structures. It is padded to 16 bytes
+ *  so there will be space for exactly 21 quota-entries in a block
+ */
+struct qt_disk_dqdbheader {
+	__le32 dqdh_next_free;	/* Number of next block with free
+					 * entry */
+	__le32 dqdh_prev_free; /* Number of previous block with free
+				   * entry */
+	__le16 dqdh_entries; /* Number of valid entries in block */
+	__le16 dqdh_pad1;
+	__le32 dqdh_pad2;
+} __attribute__ ((packed));
+
+struct dquot;
+struct quota_handle;
+
+/* Operations */
+struct qtree_fmt_operations {
+	/* Convert given entry from in memory format to disk one */
+	void (*mem2disk_dqblk)(void *disk, struct dquot *dquot);
+	/* Convert given entry from disk format to in memory one */
+	void (*disk2mem_dqblk)(struct dquot *dquot, void *disk);
+	/* Is this structure for given id? */
+	int (*is_id)(void *disk, struct dquot *dquot);
+};
+
+/* Inmemory copy of version specific information */
+struct qtree_mem_dqinfo {
+	unsigned int dqi_blocks;	/* # of blocks in quota file */
+	unsigned int dqi_free_blk;	/* First block in list of free blocks */
+	unsigned int dqi_free_entry;	/* First block with free entry */
+	unsigned int dqi_entry_size;	/* Size of quota entry in quota file */
+	struct qtree_fmt_operations *dqi_ops;	/* Operations for entry
+						 * manipulation */
+};
+
+void qtree_write_dquot(struct dquot *dquot);
+struct dquot *qtree_read_dquot(struct quota_handle *h, qid_t id);
+void qtree_delete_dquot(struct dquot *dquot);
+int qtree_entry_unused(struct qtree_mem_dqinfo *info, char *disk);
+int qtree_scan_dquots(struct quota_handle *h,
+		int (*process_dquot) (struct dquot *, void *), void *data);
+
+int qtree_dqstr_in_blk(struct qtree_mem_dqinfo *info);
+
+#endif /* _LINUX_QUOTAIO_TREE_H */
diff --git a/fsck/quotaio_v2.c b/fsck/quotaio_v2.c
new file mode 100644
index 0000000..478cd17
--- /dev/null
+++ b/fsck/quotaio_v2.c
@@ -0,0 +1,284 @@
+/*
+ * Implementation of new quotafile format
+ *
+ * Jan Kara <jack@suse.cz> - sponsored by SuSE CR
+ * Hyojun Kim <hyojun@google.com> - Ported to f2fs-tools
+ */
+
+#include "config.h"
+#include <sys/types.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "common.h"
+
+#include "quotaio_v2.h"
+#include "dqblk_v2.h"
+#include "quotaio_tree.h"
+
+static int v2_check_file(struct quota_handle *h, int type);
+static int v2_init_io(struct quota_handle *h);
+static int v2_new_io(struct quota_handle *h);
+static int v2_write_info(struct quota_handle *h);
+static struct dquot *v2_read_dquot(struct quota_handle *h, qid_t id);
+static int v2_commit_dquot(struct dquot *dquot);
+static int v2_scan_dquots(struct quota_handle *h,
+			  int (*process_dquot) (struct dquot *dquot,
+						void *data),
+			  void *data);
+static int v2_report(struct quota_handle *h, int verbose);
+
+struct quotafile_ops quotafile_ops_2 = {
+	.check_file	= v2_check_file,
+	.init_io 	= v2_init_io,
+	.new_io 	= v2_new_io,
+	.write_info	= v2_write_info,
+	.read_dquot	= v2_read_dquot,
+	.commit_dquot	= v2_commit_dquot,
+	.scan_dquots	= v2_scan_dquots,
+	.report		= v2_report,
+};
+
+/*
+ * Copy dquot from disk to memory
+ */
+static void v2r1_disk2memdqblk(struct dquot *dquot, void *dp)
+{
+	struct util_dqblk *m = &dquot->dq_dqb;
+	struct v2r1_disk_dqblk *d = dp, empty;
+
+	dquot->dq_id = le32_to_cpu(d->dqb_id);
+	m->dqb_ihardlimit = le64_to_cpu(d->dqb_ihardlimit);
+	m->dqb_isoftlimit = le64_to_cpu(d->dqb_isoftlimit);
+	m->dqb_bhardlimit = le64_to_cpu(d->dqb_bhardlimit);
+	m->dqb_bsoftlimit = le64_to_cpu(d->dqb_bsoftlimit);
+	m->dqb_curinodes = le64_to_cpu(d->dqb_curinodes);
+	m->dqb_curspace = le64_to_cpu(d->dqb_curspace);
+	m->dqb_itime = le64_to_cpu(d->dqb_itime);
+	m->dqb_btime = le64_to_cpu(d->dqb_btime);
+
+	memset(&empty, 0, sizeof(struct v2r1_disk_dqblk));
+	empty.dqb_itime = cpu_to_le64(1);
+	if (!memcmp(&empty, dp, sizeof(struct v2r1_disk_dqblk)))
+		m->dqb_itime = 0;
+}
+
+/*
+ * Copy dquot from memory to disk
+ */
+static void v2r1_mem2diskdqblk(void *dp, struct dquot *dquot)
+{
+	struct util_dqblk *m = &dquot->dq_dqb;
+	struct v2r1_disk_dqblk *d = dp;
+
+	d->dqb_ihardlimit = cpu_to_le64(m->dqb_ihardlimit);
+	d->dqb_isoftlimit = cpu_to_le64(m->dqb_isoftlimit);
+	d->dqb_bhardlimit = cpu_to_le64(m->dqb_bhardlimit);
+	d->dqb_bsoftlimit = cpu_to_le64(m->dqb_bsoftlimit);
+	d->dqb_curinodes = cpu_to_le64(m->dqb_curinodes);
+	d->dqb_curspace = cpu_to_le64(m->dqb_curspace);
+	d->dqb_itime = cpu_to_le64(m->dqb_itime);
+	d->dqb_btime = cpu_to_le64(m->dqb_btime);
+	d->dqb_id = cpu_to_le32(dquot->dq_id);
+	if (qtree_entry_unused(&dquot->dq_h->qh_info.u.v2_mdqi.dqi_qtree, dp))
+		d->dqb_itime = cpu_to_le64(1);
+}
+
+static int v2r1_is_id(void *dp, struct dquot *dquot)
+{
+	struct v2r1_disk_dqblk *d = dp;
+	struct qtree_mem_dqinfo *info =
+			&dquot->dq_h->qh_info.u.v2_mdqi.dqi_qtree;
+
+	if (qtree_entry_unused(info, dp))
+		return 0;
+	return le32_to_cpu(d->dqb_id) == dquot->dq_id;
+}
+
+static struct qtree_fmt_operations v2r1_fmt_ops = {
+	.mem2disk_dqblk = v2r1_mem2diskdqblk,
+	.disk2mem_dqblk = v2r1_disk2memdqblk,
+	.is_id = v2r1_is_id,
+};
+
+/*
+ * Copy dqinfo from disk to memory
+ */
+static inline void v2_disk2memdqinfo(struct util_dqinfo *m,
+				     struct v2_disk_dqinfo *d)
+{
+	m->dqi_bgrace = le32_to_cpu(d->dqi_bgrace);
+	m->dqi_igrace = le32_to_cpu(d->dqi_igrace);
+	m->u.v2_mdqi.dqi_flags = le32_to_cpu(d->dqi_flags) & V2_DQF_MASK;
+	m->u.v2_mdqi.dqi_qtree.dqi_blocks = le32_to_cpu(d->dqi_blocks);
+	m->u.v2_mdqi.dqi_qtree.dqi_free_blk =
+		le32_to_cpu(d->dqi_free_blk);
+	m->u.v2_mdqi.dqi_qtree.dqi_free_entry =
+				le32_to_cpu(d->dqi_free_entry);
+}
+
+/*
+ * Copy dqinfo from memory to disk
+ */
+static inline void v2_mem2diskdqinfo(struct v2_disk_dqinfo *d,
+				     struct util_dqinfo *m)
+{
+	d->dqi_bgrace = cpu_to_le32(m->dqi_bgrace);
+	d->dqi_igrace = cpu_to_le32(m->dqi_igrace);
+	d->dqi_flags = cpu_to_le32(m->u.v2_mdqi.dqi_flags & V2_DQF_MASK);
+	d->dqi_blocks = cpu_to_le32(m->u.v2_mdqi.dqi_qtree.dqi_blocks);
+	d->dqi_free_blk =
+		cpu_to_le32(m->u.v2_mdqi.dqi_qtree.dqi_free_blk);
+	d->dqi_free_entry =
+		cpu_to_le32(m->u.v2_mdqi.dqi_qtree.dqi_free_entry);
+}
+
+static int v2_read_header(struct quota_handle *h, struct v2_disk_dqheader *dqh)
+{
+	if (h->read(&h->qh_qf, 0, dqh, sizeof(struct v2_disk_dqheader)) !=
+			sizeof(struct v2_disk_dqheader))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * Check whether given quota file is in our format
+ */
+static int v2_check_file(struct quota_handle *h, int type)
+{
+	struct v2_disk_dqheader dqh;
+	int file_magics[] = INITQMAGICS;
+	int be_magic;
+
+	if (!v2_read_header(h, &dqh))
+		return 0;
+
+	be_magic = be32_to_cpu((__force __be32)dqh.dqh_magic);
+	if (be_magic == file_magics[type]) {
+		log_err("Your quota file is stored in wrong endianity");
+		return 0;
+	}
+	if (V2_VERSION != le32_to_cpu(dqh.dqh_version))
+		return 0;
+	return 1;
+}
+
+/*
+ * Open quotafile
+ */
+static int v2_init_io(struct quota_handle *h)
+{
+	struct v2_disk_dqinfo ddqinfo;
+
+	h->qh_info.u.v2_mdqi.dqi_qtree.dqi_entry_size =
+		sizeof(struct v2r1_disk_dqblk);
+	h->qh_info.u.v2_mdqi.dqi_qtree.dqi_ops = &v2r1_fmt_ops;
+
+	/* Read information about quotafile */
+	if (h->read(&h->qh_qf, V2_DQINFOOFF, &ddqinfo,
+			 sizeof(ddqinfo)) != sizeof(ddqinfo))
+		return -1;
+	v2_disk2memdqinfo(&h->qh_info, &ddqinfo);
+	return 0;
+}
+
+/*
+ * Initialize new quotafile
+ */
+static int v2_new_io(struct quota_handle *h)
+{
+	int file_magics[] = INITQMAGICS;
+	struct v2_disk_dqheader ddqheader;
+	struct v2_disk_dqinfo ddqinfo;
+
+	if (h->qh_fmt != QFMT_VFS_V1)
+		return -1;
+
+	/* Write basic quota header */
+	ddqheader.dqh_magic = cpu_to_le32(file_magics[h->qh_type]);
+	ddqheader.dqh_version = cpu_to_le32(V2_VERSION);
+	if (h->write(&h->qh_qf, 0, &ddqheader, sizeof(ddqheader)) !=
+			sizeof(ddqheader))
+		return -1;
+
+	/* Write information about quotafile */
+	h->qh_info.dqi_bgrace = MAX_DQ_TIME;
+	h->qh_info.dqi_igrace = MAX_IQ_TIME;
+	h->qh_info.u.v2_mdqi.dqi_flags = 0;
+	h->qh_info.u.v2_mdqi.dqi_qtree.dqi_blocks = QT_TREEOFF + 1;
+	h->qh_info.u.v2_mdqi.dqi_qtree.dqi_free_blk = 0;
+	h->qh_info.u.v2_mdqi.dqi_qtree.dqi_free_entry = 0;
+	h->qh_info.u.v2_mdqi.dqi_qtree.dqi_entry_size =
+				sizeof(struct v2r1_disk_dqblk);
+	h->qh_info.u.v2_mdqi.dqi_qtree.dqi_ops = &v2r1_fmt_ops;
+	v2_mem2diskdqinfo(&ddqinfo, &h->qh_info);
+	if (h->write(&h->qh_qf, V2_DQINFOOFF, &ddqinfo,
+			  sizeof(ddqinfo)) !=
+	    sizeof(ddqinfo))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * Write information (grace times to file)
+ */
+static int v2_write_info(struct quota_handle *h)
+{
+	struct v2_disk_dqinfo ddqinfo;
+
+	v2_mem2diskdqinfo(&ddqinfo, &h->qh_info);
+	if (h->write(&h->qh_qf, V2_DQINFOOFF, &ddqinfo, sizeof(ddqinfo)) !=
+			sizeof(ddqinfo))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * Read dquot from disk
+ */
+static struct dquot *v2_read_dquot(struct quota_handle *h, qid_t id)
+{
+	return qtree_read_dquot(h, id);
+}
+
+/*
+ * Commit changes of dquot to disk - it might also mean deleting it when quota
+ * became fake one and user has no blocks.
+ * User can process use 'errno' to detect errstr.
+ */
+static int v2_commit_dquot(struct dquot *dquot)
+{
+	struct util_dqblk *b = &dquot->dq_dqb;
+
+	if (!b->dqb_curspace && !b->dqb_curinodes && !b->dqb_bsoftlimit &&
+	    !b->dqb_isoftlimit && !b->dqb_bhardlimit && !b->dqb_ihardlimit)
+	{
+		qtree_delete_dquot(dquot);
+	} else {
+		qtree_write_dquot(dquot);
+	}
+	return 0;
+}
+
+static int v2_scan_dquots(struct quota_handle *h,
+			  int (*process_dquot) (struct dquot *, void *),
+			  void *data)
+{
+	return qtree_scan_dquots(h, process_dquot, data);
+}
+
+/* Report information about quotafile.
+ * TODO: Not used right now, but we should be able to use this when we add
+ * support to debugfs to read quota files.
+ */
+static int v2_report(struct quota_handle *UNUSED(h), int UNUSED(verbose))
+{
+	log_err("Not Implemented.");
+	return -1;
+}
diff --git a/fsck/quotaio_v2.h b/fsck/quotaio_v2.h
new file mode 100644
index 0000000..de2db27
--- /dev/null
+++ b/fsck/quotaio_v2.h
@@ -0,0 +1,54 @@
+/*
+ *
+ *	Header file for disk format of new quotafile format
+ *
+ */
+
+#ifndef GUARD_QUOTAIO_V2_H
+#define GUARD_QUOTAIO_V2_H
+
+#include <sys/types.h>
+#include "quotaio.h"
+
+/* Offset of info header in file */
+#define V2_DQINFOOFF		sizeof(struct v2_disk_dqheader)
+/* Supported version of quota-tree format */
+#define V2_VERSION 1
+
+struct v2_disk_dqheader {
+	__le32 dqh_magic;	/* Magic number identifying file */
+	__le32 dqh_version;	/* File version */
+} __attribute__ ((packed));
+
+/* Flags for version specific files */
+#define V2_DQF_MASK  0x0000	/* Mask for all valid ondisk flags */
+
+/* Header with type and version specific information */
+struct v2_disk_dqinfo {
+	__le32 dqi_bgrace;	/* Time before block soft limit becomes
+				 * hard limit */
+	__le32 dqi_igrace;	/* Time before inode soft limit becomes
+				 * hard limit */
+	__le32 dqi_flags;	/* Flags for quotafile (DQF_*) */
+	__le32 dqi_blocks;	/* Number of blocks in file */
+	__le32 dqi_free_blk;	/* Number of first free block in the list */
+	__le32 dqi_free_entry;	/* Number of block with at least one
+					 * free entry */
+} __attribute__ ((packed));
+
+struct v2r1_disk_dqblk {
+	__le32 dqb_id;	/* id this quota applies to */
+	__le32 dqb_pad;
+	__le64 dqb_ihardlimit;	/* absolute limit on allocated inodes */
+	__le64 dqb_isoftlimit;	/* preferred inode limit */
+	__le64 dqb_curinodes;	/* current # allocated inodes */
+	__le64 dqb_bhardlimit;	/* absolute limit on disk space
+					 * (in QUOTABLOCK_SIZE) */
+	__le64 dqb_bsoftlimit;	/* preferred limit on disk space
+					 * (in QUOTABLOCK_SIZE) */
+	__le64 dqb_curspace;	/* current space occupied (in bytes) */
+	__le64 dqb_btime;	/* time limit for excessive disk use */
+	__le64 dqb_itime;	/* time limit for excessive inode use */
+} __attribute__ ((packed));
+
+#endif
diff --git a/fsck/segment.c b/fsck/segment.c
index e13f147..efbd667 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -27,9 +27,10 @@ static void write_inode(u64 blkaddr, struct f2fs_node *inode)
 void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 			struct f2fs_summary *sum, int type)
 {
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct seg_entry *se;
-	u64 blkaddr;
-	u64 offset;
+	u64 blkaddr, offset;
+	u64 old_blkaddr = *to;
 
 	blkaddr = SM_I(sbi)->main_blkaddr;
 
@@ -43,7 +44,16 @@ void reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
 	se->type = type;
 	se->valid_blocks++;
 	f2fs_set_bit(offset, (char *)se->cur_valid_map);
-	sbi->total_valid_block_count++;
+	if (c.func == FSCK) {
+		f2fs_set_main_bitmap(sbi, blkaddr, type);
+		f2fs_set_sit_bitmap(sbi, blkaddr);
+	}
+
+	if (old_blkaddr == NULL_ADDR) {
+		sbi->total_valid_block_count++;
+		if (c.func == FSCK)
+			fsck->chk.valid_blk_cnt++;
+	}
 	se->dirty = 1;
 
 	/* read/write SSA */
@@ -56,6 +66,7 @@ void new_data_block(struct f2fs_sb_info *sbi, void *block,
 {
 	struct f2fs_summary sum;
 	struct node_info ni;
+	int blkaddr = datablock_addr(dn->node_blk, dn->ofs_in_node);
 
 	ASSERT(dn->node_blk);
 	memset(block, 0, BLOCK_SZ);
@@ -64,7 +75,10 @@ void new_data_block(struct f2fs_sb_info *sbi, void *block,
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 	reserve_new_block(sbi, &dn->data_blkaddr, &sum, type);
 
-	inc_inode_blocks(dn);
+	if (blkaddr == NULL_ADDR)
+		inc_inode_blocks(dn);
+	else if (blkaddr == NEW_ADDR)
+		dn->idirty = 1;
 	set_data_blkaddr(dn);
 }
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index d26b7cf..c2b2454 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -24,6 +24,15 @@
 #include <linux/blkzoned.h>
 #endif
 
+#ifdef UNUSED
+#elif defined(__GNUC__)
+# define UNUSED(x) UNUSED_ ## x __attribute__((unused))
+#elif defined(__LCLINT__)
+# define UNUSED(x) x
+#else
+# define UNUSED(x) x
+#endif
+
 typedef u_int64_t	u64;
 typedef u_int32_t	u32;
 typedef u_int16_t	u16;
@@ -1180,6 +1189,16 @@ static inline __le64 get_cp_crc(struct f2fs_checkpoint *cp)
 	return cpu_to_le64(cp_ver);
 }
 
+static inline int exist_qf_ino(struct f2fs_super_block *sb)
+{
+	int i;
+
+	for (i = 0; i < F2FS_MAX_QUOTAS; i++)
+		if (sb->qf_ino[i])
+			return 1;
+	return 0;
+}
+
 static inline int is_qf_ino(struct f2fs_super_block *sb, nid_t ino)
 {
 	int i;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index c809225..2103f9d 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -395,9 +395,13 @@ static int f2fs_prepare_super_block(void)
 			quotatype_bits |= QUOTA_PRJ_BIT;
 	}
 
-	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++)
-		sb->qf_ino[qtype] =
-			((1 << qtype) & quotatype_bits) ? next_ino++ : 0;
+	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++) {
+		if (!((1 << qtype) & quotatype_bits))
+			continue;
+		sb->qf_ino[qtype] = cpu_to_le32(next_ino++);
+		MSG(0, "Info: add quota type = %u => %u\n",
+					qtype, next_ino - 1);
+	}
 
 	if (total_zones <= 6) {
 		MSG(1, "\tError: %d zones: Need more zones "
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
