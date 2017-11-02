From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: save a multiplication for last_nid
 calculation
Date: Thu, 02 Nov 2017 11:02:52 +0800
Message-ID: <000101d35387$2dec7d40$89c577c0$@samsung.com>
References: <CGME20171102030338epcas1p19ad41be52b4346e4828fd9e0cc92d711@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <fanofcode.li@samsung.com>)
 id 1eA5nI-0006F3-OT
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:03:48 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eA5nG-0005Z5-O1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:03:48 +0000
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Chao Yu' <chao@kernel.org>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Use a slightly easier way to calculate last_nid.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7834097..55ab330 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2642,7 +2642,7 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
                __set_bit_le(i, nm_i->nat_block_bitmap);

                nid = i * NAT_ENTRY_PER_BLOCK;
-               last_nid = (i + 1) * NAT_ENTRY_PER_BLOCK;
+               last_nid = nid + NAT_ENTRY_PER_BLOCK;

                spin_lock(&NM_I(sbi)->nid_list_lock);
                for (; nid < last_nid; nid++)
--
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
