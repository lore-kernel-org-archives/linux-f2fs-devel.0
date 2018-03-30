From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v10 16/62] xarray: Add MAINTAINERS entry
Date: Thu, 29 Mar 2018 20:41:59 -0700
Message-ID: <20180330034245.10462-17-willy@infradead.org>
References: <20180330034245.10462-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1f1kwd-0001LE-Nd
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:15 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1kwc-004tPb-8I
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:15 +0000
In-Reply-To: <20180330034245.10462-1-willy@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, James Simmons <jsimmons@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Andreas Dilger <andreas.dilger@intel.com>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

Add myself as XArray and IDR maintainer.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49236216a871..5da3adc1fabc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15327,6 +15327,18 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
 S:	Maintained
 F:	arch/x86/entry/vdso/
 
+XARRAY
+M:	Matthew Wilcox <mawilcox@microsoft.com>
+M:	Matthew Wilcox <willy@infradead.org>
+L:	linux-fsdevel@vger.kernel.org
+S:	Supported
+F:	Documentation/core-api/xarray.rst
+F:	lib/idr.c
+F:	lib/xarray.c
+F:	include/linux/idr.h
+F:	include/linux/xarray.h
+F:	tools/testing/radix-tree
+
 XC2028/3028 TUNER DRIVER
 M:	Mauro Carvalho Chehab <mchehab@s-opensource.com>
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
