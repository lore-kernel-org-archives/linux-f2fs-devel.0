From: Tao Bao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH] libf2fs: Track AOSP libsparse API change.
Date: Thu, 26 Apr 2018 00:40:09 -0700
Message-ID: <20180426074009.36270-1-tbao@google.com>
Reply-To: Tao Bao <tbao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3hoLhWgQKEO0iQPdVddVaT.RdbaXcjm-UrUh-STkTaaXhih.hdjgRTUdgVT.cTi@flex--tbao.bounces.google.com>)
 id 1fBbuF-0003Md-CV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Apr 2018 08:05:31 +0000
Received: from mail-io0-f202.google.com ([209.85.223.202])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fBbuD-0087tz-RR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Apr 2018 08:05:31 +0000
Received: by mail-io0-f202.google.com with SMTP id a193-v6so17087374ioa.23
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Apr 2018 01:05:29 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, tbao@google.com
Cc: jaegeuk@google.com

The libsparse in AOSP is updating the type for 'len', from 'int' to
'size_t', in the callback parameter of sparse_file_foreach_chunk(). The
value represents a chunk size, which could be legitimately larger than
INT_MAX. This patch tracks the libsparse API change.

The change is guarded with SPARSE_CALLBACK_USES_SIZE_T that's exposed as
part of the libsparse change. This allows f2fs-tools to keep working
against older libsparse versions.

Signed-off-by: Tao Bao <tbao@google.com>
---
 lib/libf2fs_io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 4781517..76d283d 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -114,8 +114,13 @@ static int sparse_write_blk(__u64 block, int count, const void *buf)
 	return 0;
 }
 
+#ifdef SPARSE_CALLBACK_USES_SIZE_T
+static int sparse_import_segment(void *UNUSED(priv), const void *data,
+		size_t len, unsigned int block, unsigned int nr_blocks)
+#else
 static int sparse_import_segment(void *UNUSED(priv), const void *data, int len,
 		unsigned int block, unsigned int nr_blocks)
+#endif
 {
 	/* Ignore chunk headers, only write the data */
 	if (!nr_blocks || len % F2FS_BLKSIZE)
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
