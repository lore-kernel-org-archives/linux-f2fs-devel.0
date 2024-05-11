Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0E7C25B10
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 May 2024 03:07:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5d5B-0003KM-PE;
	Sat, 11 May 2024 03:07:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s5d5A-0003K9-Mx
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 03:07:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cwabf059HcBoD50E9s3Uhj3WZXOAa9Pi4aLxbc+Xh8k=; b=hoORppJL/lfPji9TT1O9iV4yau
 26RHZlsjeVNYt//FRDjrMSUsZmOd65DL+oDtHXHdafkGwPD0o04+2CRSItXgfqoiclS9Zaej4iomI
 wZ/O8ISH82ILCrrHREDd7XHTfKno6e2ihcSjdm0rAdK9ss3ffKxx8CCbufCufROHOikM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Cwabf059HcBoD50E9s3Uhj3WZXOAa9Pi4aLxbc+Xh8k=; b=KC4ogxsWqQFNTVz13vseAJiDkH
 BUeC2tWZYDlfTe5b45lmCHz9kxCBbBO/DBvN2tiB3VjQtQt5Ze3t+6cCSSLBEXZchRBecYGcLesWf
 yaUcejZzgIG/F2alnSHAX7M0OSNGbjDcdTTBpWitEeoWBpDeCS5O1qBtDKQoGcVDlHRM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5d5A-0002WG-Df for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 03:07:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4E97662040;
 Sat, 11 May 2024 03:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309C9C113CC;
 Sat, 11 May 2024 03:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715396841;
 bh=tUeUKCC+BkSiygOzJE+EPuwly0aTyMTDrm5LYkAqvWQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V8h3e0jtRgzKJdaC4yEIYUqNETVyMAr8trAIbZSSOSvsCMa4TnOnhHB72sWMMcwzg
 7hIBpdHQVB/mMCxDVijc2JDYihUcHlFkAb0mGQddTpN6R9kp7Z99hdeAoUrV0ufK/X
 3imq6XDSOXCelX74vL20KR3FrgFzKiu4R+dq1tpfdS5ynDIhI+pXoXKrZxB4NY3FDb
 /YJ8FtKKF7kVexhvlsWKjuot++gUd5tXqFVAWI7AuVKaqTYHAwHpJQzcMvcIEDA/uF
 oWnxOTZQBnxj6PzCTT+CawEZVh41W5s+4TLOI+KnJhsxv+VSGhj5/MTq3jhIcZuVUW
 /NH7CGjEzmn5w==
Message-ID: <02a4e80f-a146-4862-8399-3db42979b8fb@kernel.org>
Date: Sat, 11 May 2024 11:07:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240506103313.773503-1-chao@kernel.org>
 <20240506103313.773503-3-chao@kernel.org> <ZjzxWp4-wmpCzBeB@google.com>
 <b58d0a62-9491-4b77-a3be-70331f849bb8@kernel.org>
 <Zj2WWpHmHaWKbDgG@google.com>
 <948ecc86-63f5-48bb-b71c-61d57cbf446c@kernel.org>
 <Zj6-Fl5OQrHyg0g_@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zj6-Fl5OQrHyg0g_@google.com>
X-Headers-End: 1s5d5A-0002WG-Df
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix to do sanity check on i_nid
 for inline_data inode
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org,
 syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/5/11 8:38, Jaegeuk Kim wrote:
> On 05/10, Chao Yu wrote:
>> On 2024/5/10 11:36, Jaegeuk Kim wrote:
>>> On 05/10, Chao Yu wrote:
>>>> On 2024/5/9 23:52, Jaegeuk Kim wrote:
>>>>> On 05/06, Chao Yu wrote:
>>>>>> syzbot reports a f2fs bug as below:
>>>>>>
>>>>>> ------------[ cut here ]------------
>>>>>> kernel BUG at fs/f2fs/inline.c:258!
>>>>>> CPU: 1 PID: 34 Comm: kworker/u8:2 Not tainted 6.9.0-rc6-syzkaller-00012-g9e4bc4bcae01 #0
>>>>>> RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
>>>>>> Call Trace:
>>>>>>     f2fs_write_single_data_page+0xb65/0x1d60 fs/f2fs/data.c:2834
>>>>>>     f2fs_write_cache_pages fs/f2fs/data.c:3133 [inline]
>>>>>>     __f2fs_write_data_pages fs/f2fs/data.c:3288 [inline]
>>>>>>     f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3315
>>>>>>     do_writepages+0x35b/0x870 mm/page-writeback.c:2612
>>>>>>     __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1650
>>>>>>     writeback_sb_inodes+0x905/0x1260 fs/fs-writeback.c:1941
>>>>>>     wb_writeback+0x457/0xce0 fs/fs-writeback.c:2117
>>>>>>     wb_do_writeback fs/fs-writeback.c:2264 [inline]
>>>>>>     wb_workfn+0x410/0x1090 fs/fs-writeback.c:2304
>>>>>>     process_one_work kernel/workqueue.c:3254 [inline]
>>>>>>     process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
>>>>>>     worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>>>>>>     kthread+0x2f2/0x390 kernel/kthread.c:388
>>>>>>     ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>>>>>>     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>>>>>
>>>>>> The root cause is: inline_data inode can be fuzzed, so that there may
>>>>>> be valid blkaddr in its direct node, once f2fs triggers background GC
>>>>>> to migrate the block, it will hit f2fs_bug_on() during dirty page
>>>>>> writeback.
>>>>>>
>>>>>> Let's add sanity check on i_nid field for inline_data inode, meanwhile,
>>>>>> forbid to migrate inline_data inode's data block to fix this issue.
>>>>>>
>>>>>> Reported-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com
>>>>>> Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000d103ce06174d7ec3@google.com
>>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>>> ---
>>>>>>     fs/f2fs/f2fs.h   |  2 +-
>>>>>>     fs/f2fs/gc.c     |  6 ++++++
>>>>>>     fs/f2fs/inline.c | 17 ++++++++++++++++-
>>>>>>     fs/f2fs/inode.c  |  2 +-
>>>>>>     4 files changed, 24 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>> index fced2b7652f4..c876813b5532 100644
>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>> @@ -4146,7 +4146,7 @@ extern struct kmem_cache *f2fs_inode_entry_slab;
>>>>>>      * inline.c
>>>>>>      */
>>>>>>     bool f2fs_may_inline_data(struct inode *inode);
>>>>>> -bool f2fs_sanity_check_inline_data(struct inode *inode);
>>>>>> +bool f2fs_sanity_check_inline_data(struct inode *inode, struct page *ipage);
>>>>>>     bool f2fs_may_inline_dentry(struct inode *inode);
>>>>>>     void f2fs_do_read_inline_data(struct page *page, struct page *ipage);
>>>>>>     void f2fs_truncate_inline_inode(struct inode *inode,
>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>> index e86c7f01539a..041957750478 100644
>>>>>> --- a/fs/f2fs/gc.c
>>>>>> +++ b/fs/f2fs/gc.c
>>>>>> @@ -1563,6 +1563,12 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>>>>     				continue;
>>>>>>     			}
>>>>>> +			if (f2fs_has_inline_data(inode)) {
>>>>>> +				iput(inode);
>>>>>> +				set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>>> +				continue;
>>>>>
>>>>> Any race condtion to get this as false alarm?
>>>>
>>>> Since there is no reproducer for the bug, I doubt it was caused by metadata
>>>> fuzzing, something like this:
>>>>
>>>> - inline inode has one valid blkaddr in i_addr or in dnode reference by i_nid;
>>>> - SIT/SSA entry of the block is valid;
>>>> - background GC migrates the block;
>>>> - kworker writeback it, and trigger the bug_on().
>>>
>>> Wasn't detected by sanity_check_inode?
>>
>> I fuzzed non-inline inode w/ below metadata fields:
>> - i_blocks = 1
>> - i_size = 2048
>> - i_inline |= 0x02
>>
>> sanity_check_inode() doesn't complain.
> 
> I mean, the below sanity_check_inode() can cover the fuzzed case? I'm wondering

I didn't figure out a generic way in sanity_check_inode() to catch all fuzzed cases.

e.g.
case #1
- blkaddr, its dnode, SSA and SIT are consistent
- dnode.footer.ino points to inline inode
- inline inode doesn't link to the donde

Something like fuzzed special file, please check details in below commit:

9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")

case #2
- blkaddr, its dnode, SSA and SIT are consistent
- blkaddr locates in inline inode's i_addr

Thanks,

> whether we really need to check it in the gc path.
> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thoughts?
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>> +			}
>>>>>> +
>>>>>>     			err = f2fs_gc_pinned_control(inode, gc_type, segno);
>>>>>>     			if (err == -EAGAIN) {
>>>>>>     				iput(inode);
>>>>>> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>>>>>> index ac00423f117b..067600fed3d4 100644
>>>>>> --- a/fs/f2fs/inline.c
>>>>>> +++ b/fs/f2fs/inline.c
>>>>>> @@ -33,11 +33,26 @@ bool f2fs_may_inline_data(struct inode *inode)
>>>>>>     	return !f2fs_post_read_required(inode);
>>>>>>     }
>>>>>> -bool f2fs_sanity_check_inline_data(struct inode *inode)
>>>>>> +static bool has_node_blocks(struct inode *inode, struct page *ipage)
>>>>>> +{
>>>>>> +	struct f2fs_inode *ri = F2FS_INODE(ipage);
>>>>>> +	int i;
>>>>>> +
>>>>>> +	for (i = 0; i < DEF_NIDS_PER_INODE; i++) {
>>>>>> +		if (ri->i_nid[i])
>>>>>> +			return true;
>>>>>> +	}
>>>>>> +	return false;
>>>>>> +}
>>>>>> +
>>>>>> +bool f2fs_sanity_check_inline_data(struct inode *inode, struct page *ipage)
>>>>>>     {
>>>>>>     	if (!f2fs_has_inline_data(inode))
>>>>>>     		return false;
>>>>>> +	if (has_node_blocks(inode, ipage))
>>>>>> +		return false;
>>>>>> +
>>>>>>     	if (!support_inline_data(inode))
>>>>>>     		return true;
>>>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>>>> index c26effdce9aa..1423cd27a477 100644
>>>>>> --- a/fs/f2fs/inode.c
>>>>>> +++ b/fs/f2fs/inode.c
>>>>>> @@ -343,7 +343,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>>>>>>     		}
>>>>>>     	}
>>>>>> -	if (f2fs_sanity_check_inline_data(inode)) {
>>>>>> +	if (f2fs_sanity_check_inline_data(inode, node_page)) {
>>>>>>     		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_data, run fsck to fix",
>>>>>>     			  __func__, inode->i_ino, inode->i_mode);
>>>>>>     		return false;
>>>>>> -- 
>>>>>> 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
