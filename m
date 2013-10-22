From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] f2fs: introduce f2fs_kmem_cache_alloc to
 hide the unfailed kmem cache allocation
Date: Tue, 22 Oct 2013 13:30:34 +0800
Message-ID: <52660D7A.9070007@cn.fujitsu.com>
References: <5264D6C7.9000202@cn.fujitsu.com> <5265F5E6.3000604@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VYUsH-0000vc-Q0
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Oct 2013 05:51:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYUsG-0000zl-8o for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Oct 2013 05:51:25 +0000
In-Reply-To: <5265F5E6.3000604@cn.fujitsu.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gao feng <gaofeng@cn.fujitsu.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

On 10/22/2013 11:49 AM, Gao feng wrote:

> On 10/21/2013 03:24 PM, Gu Zheng wrote:
>> +static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
>> +						gfp_t flags)
>> +{
>> +	void *entry = kmem_cache_alloc(cachep, flags);
>> +retry:
> 
> retry after kmem_cache_alloc?

Oh~, stupid mistake, thanks for your reminder.:)

> 
>> +	if (!entry) {
>> +		cond_resched();
>> +		goto retry;
>> +	}
>> +
>> +	return entry;
>> +}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
