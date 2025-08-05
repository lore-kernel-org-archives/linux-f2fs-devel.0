Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7763C87FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Aug 2025 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ge9G3+2YyAgND/ElLcYcbJha+kfc9pLd7zajKb1aQGo=; b=JydIIoJ5iurMv5yAm3eFDd6Lao
	ZGrBa0056AfSuvuui3Tk4tZJ7fzPFp2tVgzFagmFhKfjec/1H2DN+nDTNJ8CQppRBz6GmnfMUeOfY
	Z4OBAXhKLCk+0+4wBsZuTnv1ySmCFVzlsz8a+y6cBtkMixHBReNoy3Kkxx/QoWh/16KY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ujBea-00076y-DI;
	Tue, 05 Aug 2025 07:00:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ujBeZ-00076q-0r
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Aug 2025 07:00:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7dGsVQXdMd0Ma6Mmk3yEhdGWaGoknfhD2ZEMkjU/shs=; b=dkJVpCATt7Z/9oE5DbsGQ8EWGA
 gayBHUIuOEwd7zuexLPTEJimNAx0rWWVGzpJfiveQJlNcWcSs4hXPHyx+OYYJ2u391V8Du4nU6Kcg
 6zKSRqS42TCklJiqHasUfFfScY1EJn7pwMYSVxgTUPgw7Td8/kIrO6ptb2glsoQLguxA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7dGsVQXdMd0Ma6Mmk3yEhdGWaGoknfhD2ZEMkjU/shs=; b=GzH5WvKCIpv6nuo/l9wEsnPDvR
 RicnSPmrgj34PbpgUz15jMDt8HD0t2FRYN3fKABD8Qx8svq6wUT7PL5e5Bno9mp9Gs4rJGG0O+5jo
 Z9N4Z44CNVBfkuFSnW0KFhDvo5RaoUyGsOjBtkyuBHHOdZQ62bDBghqQQfWNJzO28GSw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ujBeY-0005GU-K0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Aug 2025 07:00:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E67A060007;
 Tue,  5 Aug 2025 07:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AA0C4CEF4;
 Tue,  5 Aug 2025 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754377200;
 bh=0uYqnbPDze1SZb+yrC9TJphGZQHscAgYxRNN8YGVzU4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=QLxw7I69GjxAu5wWXTEzk5lSJa0bN1yLsTKh0cM6AdduIqxkMm6ra/YBFrO8uV87+
 xjWNFDX6j14YDr1oJGXrm+Ej/RdGl+OiW0LBxGjaZhQBbTJ6Erd4Zso6LPS6oxMiy1
 TFaHBkja+Nwc+i0gOuC0QToEJhhXqzLc8BFFyq3uesuB9QY4YhJONGtIfNPywMKnkn
 ZY+84TkFZU8qQL1gYQJYXNloLQXvR9nvPHA1aa2Lsb1fhUqwsQ6SSydzBZgvKKeT+Y
 1dE8YffXuqwjlcRLAXryLvfctjD8q/4YbyRsh8+X4dXF58p3TtdPqEOUuONDS/qrat
 EW23PtK2mQwzw==
Message-ID: <f2f8cbd8-af49-475b-8b9c-e00250263007@kernel.org>
Date: Tue, 5 Aug 2025 14:59:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Lee <chullee@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250805065228.1473089-1-chullee@google.com>
Content-Language: en-US
In-Reply-To: <20250805065228.1473089-1-chullee@google.com>
X-Headers-End: 1ujBeY-0005GU-K0
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: add lookup_mode mount option
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/5/25 14:52, Daniel Lee wrote:
> For casefolded directories, f2fs may fall back to a linear search if
> a hash-based lookup fails. This can cause severe performance
> regressions.
> 
> While this behavior can be controlled by userspace tools (e.g. mkfs,
> fsck) by setting an on-disk flag, a kernel-level solution is needed
> to guarantee the lookup behavior regardless of the on-disk state.
> 
> This commit introduces the 'lookup_mode' mount option to provide this
> kernel-side control.
> 
> The option accepts three values:
> - perf: (Default) Enforces a hash-only lookup. The linear fallback
>   is always disabled.
> - compat: Enables the linear search fallback for compatibility with
>   directory entries from older kernels.
> - auto: Determines the mode based on the on-disk flag, preserving the
>   userspace-based behavior.
> 
> Signed-off-by: Daniel Lee <chullee@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
