From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] fs/f2fs: Code cleanup and simplify in func {find/add}_gc_inode
Date: Thu, 20 Jun 2013 17:52:39 +0800
Message-ID: <51C2D0E7.3020403@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>, guz.fnst@cn.fujitsu.com
List-Id: linux-f2fs-devel.lists.sourceforge.net


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/gc.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 1496159..0b8b439 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -314,28 +314,21 @@ static const struct victim_selection default_v_ops = {

 static struct inode *find_gc_inode(nid_t ino, struct list_head *ilist)
 {
-       struct list_head *this;
        struct inode_entry *ie;

-       list_for_each(this, ilist) {
-               ie = list_entry(this, struct inode_entry, list);
+       list_for_each_entry(ie, ilist, list)
                if (ie->inode->i_ino == ino)
                        return ie->inode;
-       }
        return NULL;
 }

 static void add_gc_inode(struct inode *inode, struct list_head *ilist)
 {
-       struct list_head *this;
-       struct inode_entry *new_ie, *ie;
+       struct inode_entry *new_ie;

-       list_for_each(this, ilist) {
-               ie = list_entry(this, struct inode_entry, list);
-               if (ie->inode == inode) {
-                       iput(inode);
-                       return;
-               }
+       if (inode == find_gc_inode(inode->i_ino, ilist)) {
+               iput(inode);
+               return;
        }
 repeat:
        new_ie = kmem_cache_alloc(winode_slab, GFP_NOFS);
-- 
1.7.7
