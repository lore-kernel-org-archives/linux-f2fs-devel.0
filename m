From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: don't skip recovering inode depend
	on i_times
Date: Fri, 4 Nov 2016 16:30:09 +0800
Message-ID: <b58aaf87-8ce4-12b1-c535-ea48d8eeee59@huawei.com>
References: <20161103162656.2982-1-chao@kernel.org>
	<20161103162656.2982-2-chao@kernel.org>
	<20161103180233.GC76264@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c2ZtY-0005sC-UP
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Nov 2016 08:30:40 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c2ZtT-000661-Cg
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Nov 2016 08:30:40 +0000
In-Reply-To: <20161103180233.GC76264@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/11/4 2:02, Jaegeuk Kim wrote:
> On Fri, Nov 04, 2016 at 12:26:56AM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> i_times of inode will be set with current system time which can be
>> configured through 'date', so it's not safe to judge dnode block as
>> garbage data depend on i_times.
> 
> This is not to detect garbage data, but to skip redundant unchanged inode.

Oops, seems 807b1e1c8e08 ("f2fs: do not recover from previous remained wrong
dnodes") did't describe like that. But after reading the codes, it looks like
the purpose of this change is to skip unchanged inode. So, commit log in
original is incorrect, right?

Thanks,


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
