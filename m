From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] Doc: f2fs: Fix typos in
	Documentation/filesystems/f2fs.txt
Date: Mon, 16 Nov 2015 20:46:28 +0900
Message-ID: <1447674388-30253-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <standby24x7@gmail.com>) id 1ZyIEv-0007KL-2P
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 11:46:29 +0000
Received: from mail-pa0-f66.google.com ([209.85.220.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZyIEu-0007xv-5Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 11:46:29 +0000
Received: by pabfh17 with SMTP id fh17so24306383pab.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 16 Nov 2015 03:46:22 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, jaegeuk@kernel.org, cm224.lee@samsung.com, chao2.yu@samsung.com, linux-f2fs-devel@lists.sourceforge.net, corbet@lwn.net, linux-doc@vger.kernel.org, rdunlap@infradead.org
Cc: Masanari Iida <standby24x7@gmail.com>

This patch fix some typos in Documentation/filesystems/f2fs.txt

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/filesystems/f2fs.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index b102b43..ad10494 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -102,7 +102,7 @@ background_gc=%s       Turn on/off cleaning operations, namely garbage
                        collection, triggered in background when I/O subsystem is
                        idle. If background_gc=on, it will turn on the garbage
                        collection and if background_gc=off, garbage collection
-                       will be truned off. If background_gc=sync, it will turn
+                       will be turned off. If background_gc=sync, it will turn
                        on synchronous garbage collection running in background.
                        Default value for this option is on. So garbage
                        collection is on by default.
@@ -145,7 +145,7 @@ extent_cache           Enable an extent cache based on rb-tree, it can cache
                        as many as extent which map between contiguous logical
                        address and physical address per inode, resulting in
                        increasing the cache hit ratio. Set by default.
-noextent_cache         Diable an extent cache based on rb-tree explicitly, see
+noextent_cache         Disable an extent cache based on rb-tree explicitly, see
                        the above extent_cache mount option.
 noinline_data          Disable the inline data feature, inline data feature is
                        enabled by default.
@@ -192,7 +192,7 @@ Files in /sys/fs/f2fs/<devname>
                               policy for garbage collection. Setting gc_idle = 0
                               (default) will disable this option. Setting
                               gc_idle = 1 will select the Cost Benefit approach
-                              & setting gc_idle = 2 will select the greedy aproach.
+                              & setting gc_idle = 2 will select the greedy approach.
 
  reclaim_segments             This parameter controls the number of prefree
                               segments to be reclaimed. If the number of prefree
@@ -298,7 +298,7 @@ The dump.f2fs shows the information of specific inode and dumps SSA and SIT to
 file. Each file is dump_ssa and dump_sit.
 
 The dump.f2fs is used to debug on-disk data structures of the f2fs filesystem.
-It shows on-disk inode information reconized by a given inode number, and is
+It shows on-disk inode information recognized by a given inode number, and is
 able to dump all the SSA and SIT entries into predefined files, ./dump_ssa and
 ./dump_sit respectively.
 
-- 
2.6.2.402.g2635c2b


------------------------------------------------------------------------------
Presto, an open source distributed SQL query engine for big data, initially
developed by Facebook, enables you to easily query your data on Hadoop in a 
more interactive manner. Teradata is also now providing full enterprise
support for Presto. Download a free open source copy now.
http://pubads.g.doubleclick.net/gampad/clk?id=250295911&iu=/4140
