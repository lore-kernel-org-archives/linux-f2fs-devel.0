From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [bug report] f2fs: issue small discard by LBA order
Date: Wed, 8 Aug 2018 10:27:29 +0800
Message-ID: <f17cd50b-4a5d-6e87-8799-9bd84c836a78@huawei.com>
References: <20180807081739.cirr6e7rc5w74ry3@kili.mountain>
 <5ba18f50-e4a1-7e90-b8b8-413eb79fc376@huawei.com>
 <20180807111930.arzvo4tmdldolgi2@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fnECT-0005OE-5r
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Aug 2018 02:27:49 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fnECQ-00CwKh-Qo
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Aug 2018 02:27:49 +0000
In-Reply-To: <20180807111930.arzvo4tmdldolgi2@mwanda>
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

On 2018/8/7 19:19, Dan Carpenter wrote:
> On Tue, Aug 07, 2018 at 06:52:45PM +0800, Chao Yu wrote:
>> Hi Dan,
>>
>> Thanks for your report, let me try fixing this issue.
>>
>> Out of curiosity, the bug was introduced in __issue_discard_cmd_range() early
>> instead of recent commit 20ee4382322c ("f2fs: issue small discard by LBA
>> order"), did Smatch missed to check original commit?
>>
> 
> It does warn about __issue_discard_cmd_range() but I didn't look at
> which patch introduced that warning...

Actually, it was introduced at 2017, I guess Smatch has missed to check below
patch due to some reason, if we have already setup to check each commit of
released linux.

8412663d177d9 ("f2fs: support issuing/waiting discard in range")
Author's commit time: 2017-10-04 09:08:32 +0800

> 
> This code is several months old, but I don't know why it's only warning
> about it now.

Anyway, I sent a patch to fix this issue, I have simply tested with fault
injection in discard flow, it looks there is no further error reported.

[PATCH] f2fs: fix use-after-free of dicard command entry

Thanks,

> 
> regards,
> dan carpenter
> 
> 
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
