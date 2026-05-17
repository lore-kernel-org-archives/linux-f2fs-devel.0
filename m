Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ADCCD4F21
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 May 2026 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3YHHgLMLYy6meHZvWCOEzyHo0ihUXE1ps2TBozfKMLg=; b=O70kz4RwHDzk0M9O3mv/5POiT6
	/n3qS0ksAgs2TNkA3+jEQC9CrIqMyaPkW/APt+Nmi3LsPDX9aQysWaUmRrR2JsfBiGPQhjDa8RHEc
	bYx4frTdV41Tyeawr0wgtaNzPTKC4A+75OS5oneFJgKQSW/HqhvJ3fMTUIZujWnImxjw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wOXiH-0001G2-S0;
	Sun, 17 May 2026 09:23:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wOXiH-0001Fw-45
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 09:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jxfzrdlZOt4TLyijWsPcE+R0PVwsX9tTYJy1NfkzlFw=; b=UKBLi6/4OFOYzhCGOmcxQCopbp
 qM/k5YOXktomt70OEnxDSpCBOy9S82+MTA/Q5FnrFLai5tq79YGeFZ8u8Fjq6oZvCKNsKvsDjPHnE
 uQg+OgrIkLxNaNSVBE5mQbM41z+beMlVqdUd5WKGS89u0kioh/ffSBiN4krki2jvlf7s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jxfzrdlZOt4TLyijWsPcE+R0PVwsX9tTYJy1NfkzlFw=; b=V+mDoyOH5wMDPu5HOeITHOqhrY
 sQTvPPjISqIjrCS5TBdavrIg1G8SEdM2Rew+tC7ofP/RLTj4txz4lxX406gjkBamOroO1IblSfC2t
 c3K5X2lpd08Fvfo197pr0cAaakeK0fqJcRrGCgff5ANSiykLVF41I35kz7iMMItRVZw0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOXiG-0002mX-NW for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 09:23:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D98914447D;
 Sun, 17 May 2026 09:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9103BC2BCB0;
 Sun, 17 May 2026 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779009783;
 bh=4nksWu0m5kxHNf0/X0U5fvtysZjFrwrOvwoPmJNHSKU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=aTP7OWrQ6YIlqjMcCZu2BrR4gIeqWaTpESdTjMJs9T4/v91oq/FWb8V50PE3cikD3
 Nq9G3DH8FnhTuPIItmpPySCbWFH66FRwlKIbcyJuzr5d50r39XJiC1CH9pRQANmTYm
 RHR2F11izf5hItFC1kBGKxYQaG5gU1SUtFu3JqljsVTVhzHhQ1+EzeSXqrgDEuB9Hc
 oJGGMuL1XPYkjDTf1s4hEuhRCZIjS2fub7CqOh3e/BVVhL7uF9S9tsD+zkuTyAVM0Z
 KocYkTpWMWB4avrCTxMt08Ld9tQHnaAZGV1gTSExBApfQUTpfoPNJ3a23dgp1CQvdR
 uc9eN0e7+z+TA==
Message-ID: <76b19184-4b2e-445f-91a1-2f4cf48a3804@kernel.org>
Date: Sun, 17 May 2026 17:22:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Deepanshu Kartikey <kartikey406@gmail.com>, jaegeuk@kernel.org
References: <20260510042336.94751-1-kartikey406@gmail.com>
Content-Language: en-US
In-Reply-To: <20260510042336.94751-1-kartikey406@gmail.com>
X-Headers-End: 1wOXiG-0002mX-NW
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: initialize ino_entry_info before
 checkpoint load
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
Cc: stable@kernel.org, syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/10/2026 12:23 PM, Deepanshu Kartikey wrote:
> When f2fs_get_valid_checkpoint() fails during mount (e.g. due to an
> invalid checkpoint CRC on a malformed image), f2fs_fill_super() takes
> an error path that eventually calls iput() on the root inode. This
> invokes f2fs_drop_inode() -> f2fs_exist_written_data(), which acquires
> sbi->im[]->ino_lock. However, f2fs_init_ino_entry_info() has not run
> yet at this point, so the spinlock is uninitialized and lockdep
> complains:
> 
>    F2FS-fs (loop0): invalid crc value
>    F2FS-fs (loop0): Failed to get valid F2FS checkpoint
>    INFO: trying to register non-static key.
>    The code is fine but needs lockdep annotation, or maybe
>    you didn't initialize this object before use?
>    ...
>     f2fs_exist_written_data+0x53/0x90 fs/f2fs/checkpoint.c:787
>     f2fs_drop_inode+0xda/0xbf0 fs/f2fs/super.c:1852
>     iput+0x651/0xe80 fs/inode.c:2009
>     f2fs_fill_super+0x6047/0x7850 fs/f2fs/super.c:5461
> 
> Move f2fs_init_ino_entry_info() to before f2fs_get_valid_checkpoint()
> so that sbi->im[] is always fully initialized before any error path
> can trigger iput() -> f2fs_drop_inode(). The init function only
> depends on raw superblock fields (BLKS_PER_SEG, F2FS_CP_PACKS,
> NR_CURSEG_PERSIST_TYPE, __cp_payload), which are populated well
> before checkpoint load, so the move is safe.
> 
> Fixes: 3063c80776e3 ("f2fs: another way to set large folio by remembering inode number")
> Cc: stable@kernel.org
> Reported-by: syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=eec8f2693d71386bd600
> Tested-by: syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
