Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97612C5DF66
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tyg+ULL1WPA8pCSVE3uRQEaAI8R9Tp2hejUzITkF00E=; b=Qh5DPubY4o5xPpP/312jCMuUpL
	QxLiqCrCubxaOBDhcRcMCVaSmjtVn6hyGkAhZvaov7/IVrvzZac9HfCXBCkjKhnWVRY8eq32w15mK
	pvkOBvsbKd8AhjSAlUg3N/RcX9hDvrxh51eTyIC/z5KYhSDkQ8rzcrktPwCrEvp6Pxl0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvtSj-0001Nd-I0;
	Mon, 17 Aug 2026 09:16:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wvtSi-0001NX-AX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 09:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BILIPk+RjKuOUis8T4OSSsg8uFPNPIJLKoXalMr725Y=; b=j0VDVeTgSriuMDBD3bTTALAHEp
 9YSHF2/2P84adOj0C6An3W3yuj+h9EjYpHSTvZd9Xv+zNWtLR2/m+Bkn350Xa0BieuSXDZsn1Btp0
 HP85MfkFdtb+4OLWXQpsx+unVwQCOHcSMYQlP7/AavITLsTqzlU7TbEvCklwVBtilIbM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BILIPk+RjKuOUis8T4OSSsg8uFPNPIJLKoXalMr725Y=; b=Iz5BXlFrvsM7rYFZ6Vmkt1ickG
 kemLSCpwdfbBYQjq6EeflFw1EiRjOQSwQpA8jH4ApqZiZ1iI99lJVFK0JUAnIgXqYET+Qd3sitCEn
 ePAz/Od6A9paYcycn0sOHIbFngIDl7qw/haqlC7p3q5hFC6UVPOjRc6PRf/yqbIQIiD0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvtSk-0002Ab-TK for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 09:16:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDEEE601E0;
 Mon, 17 Aug 2026 09:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6A01F000E9;
 Mon, 17 Aug 2026 09:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786958209;
 bh=BILIPk+RjKuOUis8T4OSSsg8uFPNPIJLKoXalMr725Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=IbqcqRClWpzUOc+I+P1KF/yOk6h8atTSoxEdQ3rbhC6NUm7/RlBqmKR/jdhDqiCZV
 pEbVApqy/fxWrH9nEsQXWuMeCdJnUCydMgM4ELpHY29A+6uYJANyR7athHOSg01dRD
 2vmbf+KjhkOMcuIMkrzvDQMk0Nj/SjsufxQy/p2rd2BsVMvPQm4P3Dt9TlX5p7CzPX
 dvBtAmSZJMenkqce02aN9LjoqewaPJGs5I8et8QVdMEVV5DHHYDS9MHLbFaeIZ2rrL
 1W6Cmzjn5XGmXuYRB0kGJYT+6ZuE9bPsZBRAaEnr4LNpFGCTbcLk1faJt62QVnW8tT
 t4Ctm5BUMqvSw==
Message-ID: <fd7c7ecd-1270-48ec-8ecd-89b38545cba5@kernel.org>
Date: Mon, 17 Aug 2026 17:16:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260806150748.3554436-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260806150748.3554436-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wvtSk-0002Ab-TK
Subject: Re: [f2fs-dev] [RFC PATCH 0/2] f2fs: support uncached buffered I/O
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/6/26 23:07, Wenjie Qi wrote:
> This RFC series enables buffered RWF_DONTCACHE on F2FS.
> 
> The first patch keeps dropbehind folios in dropbehind-only write bios and
> defers their completion to task context when completion happens outside
> in_task().
> 
> The second patch then exposes FOP_DONTCACHE and propagates
> IOCB_DONTCACHE to write_begin folio allocation so buffered
> RWF_DONTCACHE can reach the F2FS write path.
> 
> The split keeps the write-side semantics in place before enabling the
> user-visible API.

Thanks for the patchset.

Do you have some numbers in device? maybe something like Han Qi did in
https://lore.kernel.org/linux-f2fs-devel/20250828121131.3694154-1-hanqi@vivo.com?

Thanks,

> 
> Wenjie Qi (2):
>    f2fs: keep dropbehind write bios task-context safe
>    f2fs: enable buffered RWF_DONTCACHE
> 
>   fs/f2fs/data.c | 63 +++++++++++++++++++++++++++++++++++++++-----------
>   fs/f2fs/file.c |  2 +-
>   2 files changed, 51 insertions(+), 14 deletions(-)
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
