From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] f2fs: issue small discard by LBA order
Date: Tue, 7 Aug 2018 11:17:39 +0300
Message-ID: <20180807081739.cirr6e7rc5w74ry3@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan.carpenter@oracle.com>) id 1fmxBv-0003qt-Pa
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 08:18:07 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fmxBt-00C8OM-UW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 08:18:07 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello Chao Yu,

The patch 20ee4382322c: "f2fs: issue small discard by LBA order" from
Jul 8, 2018, leads to the following Smatch warning:

	fs/f2fs/segment.c:1277 __issue_discard_cmd_orderly()
	warn: 'dc' was already freed.

fs/f2fs/segment.c
  1260          while (dc) {
  1261                  struct rb_node *node;
  1262  
  1263                  if (dc->state != D_PREP)
  1264                          goto next;
  1265  
  1266                  if (dpolicy->io_aware && !is_idle(sbi)) {
  1267                          io_interrupted = true;
  1268                          break;
  1269                  }
  1270  
  1271                  dcc->next_pos = dc->lstart + dc->len;
  1272                  __submit_discard_cmd(sbi, dpolicy, dc, &issued);
                                                           ^^
Smatch is complaining that __submit_discard_cmd() frees dc on the
error path.

  1273  
  1274                  if (issued >= dpolicy->max_requests)
  1275                          break;
  1276  next:
  1277                  node = rb_next(&dc->rb_node);
                                        ^^^^^^^^^^^
Dereference.

  1278                  dc = rb_entry_safe(node, struct discard_cmd, rb_node);
  1279          }
  1280  
  1281          blk_finish_plug(&plug);
  1282  

See also:
fs/f2fs/segment.c:2550 __issue_discard_cmd_range() warn: 'dc' was already freed.

regards,
dan carpenter

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
