From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/2] Ask git to ignore the generated
 sg_write_buffer executable
Date: Sun, 19 Aug 2018 23:04:07 -0400
Message-ID: <20180820030407.13225-2-tytso@mit.edu>
References: <20180820030407.13225-1-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1frb7m-0007ul-M4
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Aug 2018 03:45:02 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1frb7k-004sy8-P3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Aug 2018 03:45:02 +0000
In-Reply-To: <20180820030407.13225-1-tytso@mit.edu>
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
Cc: Theodore Ts'o <tytso@mit.edu>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index d5ca55d..3f04e85 100644
--- a/.gitignore
+++ b/.gitignore
@@ -50,6 +50,7 @@ stamp-h1
 /tools/fibmap.f2fs
 /tools/parse.f2fs
 /tools/f2fscrypt
+/tools/sg_write_buffer/sg_write_buffer
 
 # cscope files
 cscope.*
-- 
2.18.0.rc0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
