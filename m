From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 1/5] f2fs: update start nid only once each
 circle
Date: Mon, 10 Mar 2014 09:32:12 +0800
Message-ID: <531D161C.8080001@cn.fujitsu.com>
References: <5319A2CC.3090206@cn.fujitsu.com>
	<001301cf3ac4$3220b8c0$96622a40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WMpDI-0007kq-NJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Mar 2014 01:41:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WMpDH-0000eO-0g for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Mar 2014 01:41:08 +0000
In-Reply-To: <001301cf3ac4$3220b8c0$96622a40$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'linux-kernel' <linux-kernel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>

On 03/08/2014 07:46 PM, Chao Yu wrote:

> Hi Gu,
> 
>> -----Original Message-----
>> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
>> Sent: Friday, March 07, 2014 6:43 PM
>> To: Kim
>> Cc: linux-kernel; f2fs
>> Subject: [f2fs-dev] [PATCH 1/5] f2fs: update start nid only once each circle
>>
>>
>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> 
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
> 
>> ---
>>  fs/f2fs/node.c |    6 +++++-
>>  1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 8c14110..9653096 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1875,11 +1875,15 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
>>  	while ((found = __gang_lookup_nat_cache(nm_i,
>>  					nid, NATVEC_SIZE, natvec))) {
>>  		unsigned idx;
>> +
>> +		nid = nat_get_nid(natvec[found - 1]) + 1;
>> +
>>  		for (idx = 0; idx < found; idx++) {
>>  			struct nat_entry *e = natvec[idx];
> 
> Could we replace argument 'e' with 'natvec[idx]'? then we could remove 'e' and
> brace here.

Agree. More neat with this cleanup.

Regards,
Gu

> 
> Thanks.
> 
>> -			nid = nat_get_nid(e) + 1;
>> +
>>  			__del_from_nat_cache(nm_i, e);
>>  		}
>> +
>>  	}
>>  	f2fs_bug_on(nm_i->nat_cnt);
>>  	write_unlock(&nm_i->nat_tree_lock);
>> --
>> 1.7.7
>>
>>
>> ------------------------------------------------------------------------------
>> Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
>> With Perforce, you get hassle-free workflows. Merge that actually works.
>> Faster operations. Version large binaries.  Built-in WAN optimization and the
>> freedom to use Git, Perforce or both. Make the move to Perforce.
>> http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
