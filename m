Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2971DCA6012
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xA1D2mn2f2jNqW/9WYxLdBlM3lvlmSURU9faH2Sg7B0=; b=fgHrkrtiLfoi91CTp5ZmtqM04U
	bi6W9JS/verN2cySZmYmB44mTCRdjH/mZQYDHuu5VXv/wCoCu1YQtzsYPxJxgAH0h0Sw5ZOUmAHiO
	CTz+r7w9gaaylvW/pPJ8+YqU+COMOHTNIoTrBUC4qrYWY12qci7ptVFfHoZwe9HTsx2k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF4x7-0007ne-6f;
	Fri, 09 Oct 2026 07:23:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF4x5-0007nW-7E
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 07:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k5xr3lKilJrL0OQxQ9rOoAvwtUG141XK3q72654Keoo=; b=VxYOoCLkyVxMl5zaEB9+lCO1m0
 Ar5BT0VH73AO79t6XiSvTou54reaHRiAj7Vp397Ts7/IdRkEf/p5EGv3LHcFFp+X4pQ/6F4TGz7sT
 KKlk2bvaob/xaQd6DHpdA50trdcXrfbvGXuN7rBQfxkWeumTPDpEPZ3xHBBEPfMRtLxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k5xr3lKilJrL0OQxQ9rOoAvwtUG141XK3q72654Keoo=; b=SzEufltPWJsTquWpkXZfF01Xr1
 OXz8hnj8CATC1+C76UlddFXzHf0DIJc4vK6/m1e4Vuse7swJ6cvJI/1YBSEX8qlIoJfGjUbtVU46s
 zzvKGRu/d1zx/ENOW5bW53zEey6boo97ax2LiFSZ9HfIStaJrbDlsUzpj8RcwxMsrNfc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF4x3-0008ST-Q5 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 07:23:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 213AC602C3;
 Fri,  9 Oct 2026 07:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4C11F000FF;
 Fri,  9 Oct 2026 07:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791530607;
 bh=k5xr3lKilJrL0OQxQ9rOoAvwtUG141XK3q72654Keoo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=QIufdaMzeAzhyxlIk8JdZCVjZZmdSERIKV6YeNN8tjL1+qLUEXXIqSJWwrDfsBYld
 x+i96azDNwt4dnKnRjG/ZuGxraox0TDMR/Z4rk4s8RvntsH4dMdeZKCQnMsXfs6KW+
 d77R7V8ZNv+NEeifxTL0NJRsAkwPcHFVXPFnONlIKJJWU8+c1u08TrYG3F25uger70
 BQCNYHlEibf6m7fk/lQcxxksSRABMh8h3ZJNEoDyVd2fIDeI9ToQXdiTgizZxU4K18
 r9Xk+zebgAzq7N6tqxNnea21690kj/SNGiKPYslnji+5Bw4/l1XE5Wdu6W7uX3cf6d
 DOC/AQ+zylM+A==
Message-ID: <b55e3d43-589f-4d04-a7d3-4cc52aa66fc9@kernel.org>
Date: Fri, 9 Oct 2026 15:23:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261005192114.1511660-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261005192114.1511660-1-daeho43@gmail.com>
X-Headers-End: 1xF4x3-0008ST-Q5
Subject: Re: [f2fs-dev] [PATCH] f2fs: cache: count the temporary pins apart
 from the regular references
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/6/26 03:21, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> f2fs_unlock_cache() and f2fs_end_cache_writeback() take a temporary
> reference on the entry around clear_and_wake_up_bit(), so that the entry
> is not freed before wake_up_bit() returns. f2fs_destroy_cache() waits
> for the LOCKED and WRITEBACK bits and then expects the refcount to be 1,
> but the bit waits can return as soon as the bit is cleared, before the
> I/O completion drops the temporary reference. When the completion runs
> in process context and is preempted there (e.g. dm-flakey in
> generic/311), umount hits:
> 
>   kernel BUG at fs/f2fs/cache.c:567!
>   f2fs_destroy_cache+0x260/0x268
>   f2fs_put_super+0x1fc/0x428
> 
> Count the temporary references in units of F2FS_CACHE_PIN_BIAS, like
> GUP_PIN_COUNTING_BIAS for folios, and check only the regular references
> in f2fs_destroy_cache(). A leaked regular reference is still caught
> there, without waiting for the completion.
> 
> The pinned entry is freed by whichever of f2fs_cache_put() and
> f2fs_cache_unpin() drops the refcount to zero, as before. The shrinker
> still skips an entry while it is pinned, since the refcount is then
> neither 1 nor below 3.
> 
> Fixes: 6e392158cf54 ("f2fs: cache: pin cached block in f2fs_end_cache_writeback()")
> Fixes: 61ba87b33e87 ("f2fs: cache: pin cached block in f2fs_unlock_cache()")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
