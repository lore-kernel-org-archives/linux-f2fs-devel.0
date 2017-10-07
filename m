From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] f2fs: Fix bool initialization/comparison
Date: Sat, 07 Oct 2017 16:02:21 +0200
Message-ID: <1507383097084-400953728-9-diffsplit-thomas@m3y3r.de>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <thomas@m3y3r.de>) id 1e0q1Y-0006aL-7q
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Oct 2017 14:24:16 +0000
Received: from www17.your-server.de ([213.133.104.17])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e0q1W-0004Id-Kx
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Oct 2017 14:24:16 +0000
In-Reply-To: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Bool initializations should use true and false. Bool tests don't need
comparisons.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/fs/f2fs/data.c b/fs/f2fs/data.c
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -419,7 +419,7 @@ next:
 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
 
 	/* set submitted = 1 as a return value */
-	fio->submitted = 1;
+	fio->submitted = true;
 
 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
