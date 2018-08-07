From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [bug report] f2fs: issue small discard by LBA order
Date: Tue, 7 Aug 2018 18:52:45 +0800
Message-ID: <5ba18f50-e4a1-7e90-b8b8-413eb79fc376@huawei.com>
References: <20180807081739.cirr6e7rc5w74ry3@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fmzbp-0006wJ-HL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 10:53:01 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fmzbk-00AWBg-Fq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 10:53:01 +0000
In-Reply-To: <20180807081739.cirr6e7rc5w74ry3@kili.mountain>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dan,

Thanks for your report, let me try fixing this issue.

Out of curiosity, the bug was introduced in __issue_discard_cmd_range() early
instead of recent commit 20ee4382322c ("f2fs: issue small discard by LBA
order"), did Smatch missed to check original commit?

Thanks,

On 2018/8/7 16:17, Dan Carpenter wrote:
> Hello Chao Yu,
> 
> The patch 20ee4382322c: "f2fs: issue small discard by LBA order" from
> Jul 8, 2018, leads to the following Smatch warning:
> 
> 	fs/f2fs/segment.c:1277 __issue_discard_cmd_orderly()
> 	warn: 'dc' was already freed.
> 
> fs/f2fs/segment.c
>   1260          while (dc) {
>   1261                  struct rb_node *node;
>   1262  
>   1263                  if (dc->state != D_PREP)
>   1264                          goto next;
>   1265  
>   1266                  if (dpolicy->io_aware && !is_idle(sbi)) {
>   1267                          io_interrupted = true;
>   1268                          break;
>   1269                  }
>   1270  
>   1271                  dcc->next_pos = dc->lstart + dc->len;
>   1272                  __submit_discard_cmd(sbi, dpolicy, dc, &issued);
>                                                            ^^
> Smatch is complaining that __submit_discard_cmd() frees dc on the
> error path.
> 
>   1273  
>   1274                  if (issued >= dpolicy->max_requests)
>   1275                          break;
>   1276  next:
>   1277                  node = rb_next(&dc->rb_node);
>                                         ^^^^^^^^^^^
> Dereference.
> 
>   1278                  dc = rb_entry_safe(node, struct discard_cmd, rb_node);
>   1279          }
>   1280  
>   1281          blk_finish_plug(&plug);
>   1282  
> 
> See also:
> fs/f2fs/segment.c:2550 __issue_discard_cmd_range() warn: 'dc' was already freed.
> 
> regards,
> dan carpenter
> 
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
