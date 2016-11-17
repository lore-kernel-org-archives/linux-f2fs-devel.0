From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix fdatasync
Date: Thu, 17 Nov 2016 09:13:03 +0800
Message-ID: <0148c188-5e03-432d-b03b-3e968364b5e4@huawei.com>
References: <20161116121211.11790-1-yuchao0@huawei.com>
	<20161116121538.GA22373@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c7BHd-00047X-5d
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 01:14:33 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c7BHb-00085H-37
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Nov 2016 01:14:33 +0000
In-Reply-To: <20161116121538.GA22373@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@infradead.org>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/11/16 20:15, Christoph Hellwig wrote:
> On Wed, Nov 16, 2016 at 08:12:11PM +0800, Chao Yu wrote:
>> For below two cases, we can't guarantee data consistence:
>>
>> a)
>> 1. xfs_io "pwrite 0 4195328" "fsync"
>> 2. xfs_io "pwrite 4195328 1024" "fdatasync"
>> 3. godown
>> 4. umount & mount
>> --> isize we updated before fdatasync won't be recovered
>>
>> b)
>> 1. xfs_io "pwrite -S 0xcc 0 4202496" "fsync"
>> 2. xfs_io "fpunch 4194304 4096" "fdatasync"
>> 3. godown
>> 4. umount & mount
>> --> dnode we punched before fdatasync won't be recovered
> 
> Can you please add testcases for these to xfstests?

It's OK, will do.

> 
> .
> 


------------------------------------------------------------------------------
