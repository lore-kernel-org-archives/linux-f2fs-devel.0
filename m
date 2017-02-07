From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: introduce nid cache
Date: Tue, 7 Feb 2017 15:24:05 +0800
Message-ID: <452624a9-8b9a-843c-98df-00187a8f795a@huawei.com>
References: <20170122095331.58427-1-yuchao0@huawei.com>
	<20170124043500.GC1566@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cb08n-0006dy-TJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Feb 2017 07:24:41 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cb08i-0004wW-A4
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Feb 2017 07:24:41 +0000
In-Reply-To: <20170124043500.GC1566@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

Happy Chinese New Year! :)

On 2017/1/24 12:35, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 01/22, Chao Yu wrote:
>> In scenario of intensively node allocation, free nids will be ran out
>> soon, then it needs to stop to load free nids by traversing NAT blocks,
>> in worse case, if NAT blocks does not be cached in memory, it generates
>> IOs which slows down our foreground operations.
>>
>> In order to speed up node allocation, in this patch we introduce a new
>> option named "nid cache", when turns on this option, it will load all
>> nat entries in NAT blocks when doing mount, and organize all free nids
>> in a bitmap, for any operations related to free nid, we will query and
>> set the new prebuilded bitmap instead of reading and lookuping NAT
>> blocks, so performance of node allocation can be improved.
>>
> 
> How does this affect mount time and memory consumption?

Sorry for the delay.

Let me figure out some numbers later.

> IMO, if those do not
> raise huge concerns, we would be able to consider just replacing current free
> nid list with this bitmap.

Yup, I agree with you.

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
