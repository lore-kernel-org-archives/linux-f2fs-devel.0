Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C88C88E64
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LjaLeGapAlDM1S+aoH2MA1dRzAj5HZVI3bn4dim7AmQ=; b=LUICLibB5I35W7Fk1nqI8PBw6n
	uQBV4x6bWk/1dnzkPoRDDEGRHWCexASFTLEt9SwdYXTlUOX/VsIt+IKkNDrrLu3hYEzcdcqv6nwq6
	pna+iuvhTBn5MBHGUXZGMmvCPyfHuPULVRN6K1c84tOlU/ZI0Z6bqNTLtLgZBnnqYBC0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5wpS-0002qm-7I;
	Mon, 14 Sep 2026 02:53:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x5wpP-0002qe-IJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 02:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aaCZBmqARtvSxxKFFrF8QV2cSdsvS3naQrJCFFIWv5g=; b=VCqYEndi5DsykeRUValjpy9Xkg
 aWFJ9n7e3CHzu77476r5vvjq486QMDI3PLZs7kLdO6oBTdjFs1hfGqxv+khAeD9FdxSSHzXh2wKOT
 WsX7JRKO+6WM8RCvw2YZoZ3uZI7hxP5ryu0DE+leandcLXHRATljrwLjajHpXbItqGMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aaCZBmqARtvSxxKFFrF8QV2cSdsvS3naQrJCFFIWv5g=; b=lMVaHNPausU2sB7JoYjTgfBkSV
 kQEPXEbguQUQT170STlbm6fLWyBp5dmxF3gcQSDdsDLhbwkCgPUzRI2yUzHY6TXYC52vx8RI9sDw4
 aiwyoxl5XvMJrkovQqwewftQTpBxZPemJrB6JKZ3ooADlSvdXk4fxalyOyVfwCtyzsWI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5wpL-0000Hv-I0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 02:53:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D36B56109E;
 Mon, 14 Sep 2026 02:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CCC1F000FF;
 Mon, 14 Sep 2026 02:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789354425;
 bh=aaCZBmqARtvSxxKFFrF8QV2cSdsvS3naQrJCFFIWv5g=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=gfizOj0xnsiPzf+9AU+A+nf0RtPfN8ANTvdlOsND0U6tcy6ryZNUnW7jkEVimTja5
 HeYkXs4jeo+DwKqJrEq4bgN69f1pybx988FTonwtZmc+hFODsafUqU6K7Zwc3FlrdA
 5Rd5Ni/nBkL17ilD9Qu0TVy0J38rQNgdt5DTFwP7WM6zGXHwkxtsau+EsdEH39M2dT
 6fieZllNddUxxqEphg2+v9rOqRrg58uCPBXeXrySVIcVaTarf4hL75xBaeXcvH9GV3
 ffGJM0pvs4iFQEfYyEP9vs+oC7CJ0HeTnqoWavNaJGAL7ZyCmWWbSzv7ddYg4/Vt8D
 sFkG2yGYaxF2w==
Message-ID: <06bbc322-f0f4-41fa-b645-e5291803506e@kernel.org>
Date: Mon, 14 Sep 2026 10:53:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260911143549.909867-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260911143549.909867-1-daeho43@gmail.com>
X-Headers-End: 1x5wpL-0000Hv-I0
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: use BIT_ULL for mount option
 bitmasks
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/11/26 22:35, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Although f2fs_mount_info.opt and f2fs_fs_context.opt_mask are declared as
> unsigned long long (64 bits), the option bit manipulation macros
> (clear_opt, set_opt, test_opt) and context helpers (ctx_set_opt,
> ctx_clear_opt, ctx_test_opt) use BIT(), which expands to (UL(1) << nr).
> 
> On 32-bit architectures, sizeof(unsigned long) is 32 bits, causing shift
> count overflow warnings and functional truncation if mount option indices
> reach or exceed 32.
> 
> Replace BIT() with BIT_ULL() for mount option bitmasks and helpers.
> Additionally, introduce ctx_clear_opt_mask() and ctx_test_opt_mask()
> helpers to avoid open-coded bitwise manipulations on ctx->opt_mask.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609111633.uyRbsEUB-lkp@intel.com/
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
