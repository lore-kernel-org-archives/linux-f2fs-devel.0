From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs: SIT corruption upon fsck
Date: Wed, 17 Apr 2019 08:51:31 -0700
Message-ID: <20190417155131.GA33751@jaegeuk-macbookpro.roam.corp.google.com>
References: <CAD14+f2sT6HbP-vjwWo6A2O151hF=NqcP6_QqLEiEQaZ=QMgoQ@mail.gmail.com>
 <CAD14+f2oNaVbL6X_oHV=C4JMQMBCtH52OY6SSLEAXisza7fANQ@mail.gmail.com>
 <CAD14+f03GwTORdNyKEXo73pTW_1osGfnq6t68mN8w=ipZDrnrQ@mail.gmail.com>
 <20190417141513.GC23731@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hGmqa-0003bw-EX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 15:51:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGmqZ-00CK5P-9y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 15:51:40 +0000
Content-Disposition: inline
In-Reply-To: <20190417141513.GC23731@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 04/17, Jaegeuk Kim wrote:
> Hi Ju Hyung,
> 
> On 04/17, Ju Hyung Park wrote:
> > Oh sorry, I should have been more careful attaching the kernel log.
> > Disregard anything before 3091s mark and just pay attention to those 2 lines:
> > 
> > > [ 3091.204798] F2FS-fs (loop1): SIT is corrupted node# 2481418 vs 2517451
> > > [ 3091.204801] F2FS-fs (loop1): Failed to initialize F2FS segment manager
> 
> Could you please bisect f2fs-tools first to see whether there is any wrong
> patch? I feel like fsck is corrupting something.

nvm. I shoot the email too early. It seems that large_nat_bitmap gave old NAT
set somehow, so that NAT points the previous checkpointed node blocks, since
SSA were obsolete and some SIT were valid and others were invalid.

When considering no node block was missing from dentry, I think GC was doing
between two checkpoints.

[FSCK] Unreachable nat entries                        [Ok..] [0x0]
[FSCK] SIT valid block bitmap checking                [Fail]
[FSCK] Hard link checking for regular file            [Ok..] [0x7]
[FSCK] valid_block_count matching with CP             [Fail] [0x215805c]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x2669cb]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x2669cb]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x260f23]
[FSCK] free segment_count matched with CP             [Fail] [0xee6c]
[FSCK] next block offset is free                      [Ok..]


Chao,

BTW, why can't fsck fix this in large_nat_bitmap? Could you check the feature
in kernel side as well?

Thanks,
