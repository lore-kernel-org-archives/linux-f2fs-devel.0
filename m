Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD389C79F8C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEaiH7RiBtXsln0Ia/UVR7SpNMN6IAPbosMYYT4siFg=; b=Da93q56118/ud5ZRDbnWV4hRyy
	cXoVoD6jMN5aGtcSGWRbxFo1dXVl1a/zj8JqoHGrRp8CFdlVQYEm1UHwieysB/UmQSicT0MAlCMms
	XXhC/2PsjlY9XtzQZRwUe33vqExnxrQxDzE6EvOVBOCHcXXKEO8hqFC5UZJfHLttlqzY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4CpV-0006KP-0C;
	Wed, 09 Sep 2026 07:34:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4CpQ-0006KH-NR
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:34:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YV6vJiHkxKjkEjy7Pkh7XDkO297AeAXSrU8Uen/TxIg=; b=B2xmPRwwNfohRLMbcIHXiaID7p
 iFzzIKxR3EAV2RHuCvnptRvlpcQQ9cUm3aHfLLM/Rs5S45pZz8qdkaOXzHnfRHZobvcv5Ag71e/pY
 62Oq7tVza21Lg11J8AIbUADsUnxxTnpQHv2TN3JtfDiiWxqtLdfyv2s1qKF+UvnibXBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YV6vJiHkxKjkEjy7Pkh7XDkO297AeAXSrU8Uen/TxIg=; b=X4MnJ9n8b88kRKHHcN0wXu/Pn4
 ZbLIu4FqQEx/+4MrtP02Q+DkHCIdm0SnGqihhCZ7JQsrma2/7ds8+Z3/KkcPUhd25BTlChWvpD4V/
 P/ZwRJTaBuB5kLrTDrxag5rrX08qkQMVs1qxqBsrHAOyC611A7fyvJa75u5D/y7J8VeA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4CpO-0000DD-Ix for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:34:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF9B4601FD;
 Wed,  9 Sep 2026 07:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5351F00A3A;
 Wed,  9 Sep 2026 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788939276;
 bh=YV6vJiHkxKjkEjy7Pkh7XDkO297AeAXSrU8Uen/TxIg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Nsev6Ua/o/ASiY9cpHKfyZ6CGMPHWj8KU6JZPyNZ7JiDJNts4cA7KvE5aSlqjlC+o
 0JgBRBR6YDyw2dflhgWi12IGJ3JHCPSLrOFaW/fODdcYkxmuGG7R3hQDQSu30siTgy
 vE1Kv1ZfLUd9ir1dhAGnN5lG/VTs/G0caDgdLjGRe7Kc6Sg5SdipjLtXo6Xyib9hlM
 mg7Wcp1r+lhh/xYeznid0vj9++KZDYe8zRUFOY0rtj6rIe2ciUW2j+M0GC3kusA4h+
 w2/mazZFV0ARdc4zeMI+/oZJfBkX+f9oSjpgVIuH17b+4TFISefVKJc3zqMUcgov/L
 PP+uL1FuGbQIA==
Message-ID: <823eac07-808f-4b8e-a289-538ace853e12@kernel.org>
Date: Wed, 9 Sep 2026 15:34:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
References: <eecd3a49-d252-4d36-9e5a-44ac3eb02108@kernel.org>
 <20260907073434.2349510-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260907073434.2349510-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x4CpO-0000DD-Ix
Subject: Re: [f2fs-dev] [PATCH 06/14] f2fs: prepare mmap write faults for
 large folios
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/7/26 15:34, Nanzhe Zhao wrote:
> On Thu, 27 Aug 2026 20:36:02 +0800, Chao Yu wrote:
>> We only need to call f2fs_get_block_locked() for vmf->page?
>>
>> Hi Barry, could you please help to confirm this? Only vmf->page contain dirty
>> data, rather than whole large folio contain dirty data?
> 
> Thanks for the review. Here is the write-fault path on current
> mainline (mm/memory.c):
> 
> do_pte_missing()                          memory.c:4561
>   -> do_fault()                           memory.c:5964
>     -> do_shared_fault()                  memory.c:5914
>       -> __do_fault() -> filemap_fault()  : fault in folio (may be 16KB)
>       -> do_page_mkwrite(vmf, folio)      : page_mkwrite ONCE per folio (memory.c:5936)
>          -> vma->vm_ops->page_mkwrite(vmf)  memory.c:3684
>       -> finish_fault()                   memory.c:5617
>          -> set_pte_range()               memory.c:5558
>             if (write)
>                 entry = maybe_mkwrite(pte_mkdirty(entry), vma);   memory.c:5575
>             set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);      memory.c:5586
> 
> So page_mkwrite is entered once per folio, and afterwards the PTEs of
> all subpages are installed writable in one go - writes to other
> subpages of the same folio will not fault again. That is why
> f2fs_vm_page_mkwrite() preallocates/marks dirty_len rather than
> handling vmf->page only.
> 
> I'll add a comment in f2fs_vm_page_mkwrite() in the next version to
> make the point clear.

I see, we'd better limit the upper boundary of folio order in order to avoid
large write amplification, since even user only write 4k page via mmap, it will
dirty entire large folio, IIUC.

To Jaegeuk, Daeho, any comments?

Thanks,

> 
> Thanks,
> Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
