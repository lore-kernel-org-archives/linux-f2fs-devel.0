From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] f2fs: issue small discard by LBA order
Date: Tue, 7 Aug 2018 14:19:30 +0300
Message-ID: <20180807111930.arzvo4tmdldolgi2@mwanda>
References: <20180807081739.cirr6e7rc5w74ry3@kili.mountain>
 <5ba18f50-e4a1-7e90-b8b8-413eb79fc376@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan.carpenter@oracle.com>) id 1fn01o-0007Zb-1e
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 11:19:52 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fn01k-00CGtA-03
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 11:19:51 +0000
Content-Disposition: inline
In-Reply-To: <5ba18f50-e4a1-7e90-b8b8-413eb79fc376@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Tue, Aug 07, 2018 at 06:52:45PM +0800, Chao Yu wrote:
> Hi Dan,
> 
> Thanks for your report, let me try fixing this issue.
> 
> Out of curiosity, the bug was introduced in __issue_discard_cmd_range() early
> instead of recent commit 20ee4382322c ("f2fs: issue small discard by LBA
> order"), did Smatch missed to check original commit?
>

It does warn about __issue_discard_cmd_range() but I didn't look at
which patch introduced that warning...

This code is several months old, but I don't know why it's only warning
about it now.

regards,
dan carpenter


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
