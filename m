Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698FECD98C5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 11 Jun 2026 01:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RtgXMvWhbQAPmyEZFhD1EoCOSJy/dsvp/s0FiTDM7ho=; b=m0QLSXIY5fk75Q6aLsQx4u5a69
	KPfq28Tok2hlKA+fxh5qRB6A0zvL/IBssFsO4SIg9qeBsP+hAV3d4vd5wuYYNnPAj8spoGcAOxP39
	cbhqMbnUolp7Dv4R1MhCTr7vLG1heNiyJ7rjFwvwdXNSOa98IjGO2UEifTQne0zSw6wc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXUhf-0006SQ-8P;
	Thu, 11 Jun 2026 01:59:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wXUhd-0006SK-8z
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 11 Jun 2026 01:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=McOYuec+ZBryVc2t/FbS/SlEV7yNygFgiuKBzLf2BOs=; b=QMNp7+gaqcY8MefRfTLgHvlUs8
 pS37q3bUQbrTLpvV6zRJyR1y3FykosKAsUxCGmJhNe5MtDc5rbopWcOiFxvvPPJXQzUOnMe396c/l
 KbK6qIIynNbqXHnyUiZ0od1NqwJDXnQIhum53c138aLN0hI1t/HMZ2Qj+Q0LMm9qcaLM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=McOYuec+ZBryVc2t/FbS/SlEV7yNygFgiuKBzLf2BOs=; b=T6xEicGP6+n5v9GR4qemvcMHWR
 sk1cQhsHHIhI6TDdxGGLi8OKIESX8OB1S1DIOr13KIv0LVKkYs+PGVMKhuFBKr7NUip4LUglTtj80
 0mgyI6SZPvH3vWBBSKlAt/nd486SLM1WX/dXE6wNAfnE+c8Gi1yCoxjq2T67WzT2mJSw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXUhb-0001k3-2L for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 11 Jun 2026 01:59:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 90F1E601FC;
 Thu, 11 Jun 2026 01:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E421F00893;
 Thu, 11 Jun 2026 01:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781143156;
 bh=McOYuec+ZBryVc2t/FbS/SlEV7yNygFgiuKBzLf2BOs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=O+veYYb/Dio7jbtmpRb0KPZzlmevMUoGkLQ2X3wLmlkRO5otSwUtufGB0ug0WbQqn
 phHrL1SeoqLLsLobXVuOobi1570qPIPxFOJ/j0pz04aoS07hr9vMGMsHMDMLDIgXc1
 XKFdQWEF4xzsm6yHeW6xmxLIAJ+qBSCmhF1KSENFhL7Ocqm9XVoOB8vvS6MPsskD/T
 V1SmtjfQz8lal1UFFEcaxck4tZ6rIdu+2KmLrDVphZW/RS4P9fpFoyTMz7+TJ0t83b
 YfChKlMQ+9kwDX7BTLozsVnCujAii+yK4CqpoTdxEpexemfx+/Leww+Vsn8ULA11Bm
 uxS1hy5fZjkfQ==
Message-ID: <09c023dd-d0a2-4de0-87d5-ceb551c2e3e0@kernel.org>
Date: Thu, 11 Jun 2026 09:59:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Cen <rollkingzzc@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260524143738.1966071-1-rollkingzzc@gmail.com>
Content-Language: en-US
In-Reply-To: <20260524143738.1966071-1-rollkingzzc@gmail.com>
X-Headers-End: 1wXUhb-0001k3-2L
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate ACL entry sizes in
 f2fs_acl_from_disk()
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
Cc: zerocling0077@gmail.com, 2045gemini@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/24/26 22:37, Zhang Cen wrote:
> f2fs_acl_count() only validates the aggregate ACL xattr length. A
> malformed ACL can still place ACL_USER or ACL_GROUP in a slot that only
> contains struct f2fs_acl_entry_short bytes, and f2fs_acl_from_disk()
> then reads entry->e_id before verifying that a full entry fits.
> 
> Require a short entry before reading e_tag and e_perm, and require a
> full entry before reading e_id for ACL_USER and ACL_GROUP. This keeps
> corrupted ACL xattrs on the existing -EINVAL path without reading past
> the copied xattr value.
> 
> Validation reproduced this kernel report:
> KASAN slab-out-of-bounds in __f2fs_get_acl+0x6fb/0x7e0
> RIP: 0033:0x7f4b835ea7aa
> The buggy address belongs to the object at ffff888114589960 which belongs
> to the cache kmalloc-8 of size 8
> The buggy address is located 0 bytes to the right of allocated 8-byte
> region [ffff888114589960, ffff888114589968)
> Read of size 4
> Call trace:
>   dump_stack_lvl+0x66/0xa0 (?:?)
>   print_report+0xce/0x630 (?:?)
>   __f2fs_get_acl+0x6fb/0x7e0 (fs/f2fs/acl.c:169)
>   srso_alias_return_thunk+0x5/0xfbef5 (?:?)
>   __virt_addr_valid+0x224/0x430 (?:?)
>   kasan_report+0xe0/0x110 (?:?)
>   __f2fs_get_acl+0x5/0x7e0 (fs/f2fs/acl.c:169)
>   __get_acl+0x281/0x380 (?:?)
>   vfs_get_acl+0x10b/0x190 (?:?)
>   do_get_acl+0x2a/0x410 (?:?)
>   do_get_acl+0x9/0x410 (?:?)
>   do_getxattr+0xe8/0x260 (?:?)
>   filename_getxattr+0xd1/0x140 (?:?)
>   do_getname+0x2d/0x2d0 (?:?)
>   path_getxattrat+0x16c/0x200 (?:?)
>   lock_release+0xc8/0x290 (?:?)
>   cgroup_update_frozen+0x9d/0x320 (?:?)
>   lockdep_hardirqs_on_prepare+0xea/0x1a0 (?:?)
>   trace_hardirqs_on+0x1a/0x170 (?:?)
>   _raw_spin_unlock_irq+0x28/0x50 (?:?)
>   do_syscall_64+0x115/0x6a0 (arch/x86/entry/syscall_64.c:87)
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f (?:?)
> 
> Fixes: af48b85b8cd3 ("f2fs: add xattr and acl functionalities")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> ---
>  fs/f2fs/acl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> index fa8d81a30fb9..290fee451637 100644
> --- a/fs/f2fs/acl.c
> +++ b/fs/f2fs/acl.c
> @@ -70,7 +70,7 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
>  
>  	for (i = 0; i < count; i++) {
>  
> -		if ((char *)entry > end)
> +		if ((char *)entry + sizeof(struct f2fs_acl_entry_short) > end)

unlikely()?

Should return -EFSCORRUPTED instead of -EINVAL?

>  			goto fail;
>  
>  		acl->a_entries[i].e_tag  = le16_to_cpu(entry->e_tag);
> @@ -86,6 +86,8 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
>  			break;
>  
>  		case ACL_USER:
> +			if ((char *)entry + sizeof(struct f2fs_acl_entry) > end)

Ditto,

> +				goto fail;
>  			acl->a_entries[i].e_uid =
>  				make_kuid(&init_user_ns,
>  						le32_to_cpu(entry->e_id));
> @@ -93,6 +95,8 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
>  					sizeof(struct f2fs_acl_entry));
>  			break;
>  		case ACL_GROUP:
> +			if ((char *)entry + sizeof(struct f2fs_acl_entry) > end)

Ditto,

Thanks,

> +				goto fail;
>  			acl->a_entries[i].e_gid =
>  				make_kgid(&init_user_ns,
>  						le32_to_cpu(entry->e_id));



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
