Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0772E77184
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Dec 2024 12:22:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tOFY6-0004sP-97;
	Thu, 19 Dec 2024 12:22:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@redhat.com>) id 1tOFY4-0004sH-UF
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Dec 2024 12:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2cMCLi4zVEMDj7Al3ElXyo8OOv7M+q2sc/pVW1fsv0s=; b=WM5N3LLJoknsryIsgN/YAmZPeR
 Jw3oVn+3b/V5CAAF/3Mfan4ToPWS85CguVA8DdhAd8pyU6akxzrvbGhAyCtDRwg0MItmnTKAZS6Qn
 rEgUYeO6CciyO3uDxihVH5NLA65YpbIPnFGRcl5uePZBraV7u4K1DPkPCM415A3eDUJc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2cMCLi4zVEMDj7Al3ElXyo8OOv7M+q2sc/pVW1fsv0s=; b=FIS3IUkKFhhlqPZ4H7kFspwSLH
 T8HT5owwTjhgVgP1wnASRTFdn6aPv9DFDK3L4NPyBumQJvjyNJUr25xK79CkjKVmixiTXEmJz9j3U
 BTSOiaXvDwv9muuntRh2oI8RblG4QEr7nBaE2g1SuCwCTa0dfT9Y+e+Wm3NtGIz5T5IE=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tOFY3-0001U6-Me for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Dec 2024 12:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cMCLi4zVEMDj7Al3ElXyo8OOv7M+q2sc/pVW1fsv0s=;
 b=Zr/hFTebVq5q4gReMzcmT7HxdrFHPm85nXPYP/FTyYsUUmsR4CAepLCZTFOinc19psKPzp
 iJocer6rSddGCwKBEr68Wv+BkIVo1QNylMyqGuyXHIZLaR6MCyrlEv2AeL6inqg60ETkZf
 EC1T60aSVhZkN5qgJIfC7b0HizxUX/8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-b8J8-cWTOwWSESuzXrCznQ-1; Thu, 19 Dec 2024 07:22:28 -0500
X-MC-Unique: b8J8-cWTOwWSESuzXrCznQ-1
X-Mimecast-MFC-AGG-ID: b8J8-cWTOwWSESuzXrCznQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467ae19e34bso22222681cf.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Dec 2024 04:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610947; x=1735215747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cMCLi4zVEMDj7Al3ElXyo8OOv7M+q2sc/pVW1fsv0s=;
 b=Orspw0pmQWXEcBYTIajz60BhvMDsOkSsLpvOgCkh1/uJLU65gfgP9FuTovR0vbTGsa
 jPnB8lBoRFtWvUd7ZjIvllxFvr4OXdT+z0lFntsmtzLa0JMNVXrFPgIpj5NqxNSfmtxY
 9KajKcFKXP4ueM+fv8MOC4AGHAE45SA96IBhx8YmZXtp4oHWFg7NoV/WJiTpw4ekBtB3
 S3MS0TuhyHTA9Zk2fyIQOuGS/fh5QbJEEzWlk4EdYcPb064Crx3nVokKr0qHEOl55OqV
 oMDSSbZBtzpmR2fpCmer5Cf94Po7ldVzX5VWCQMDlLXmY6qZyDERqK4KjqK71hNtTk7h
 LaeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWurS05a8pNZLbhKgW4Hn0yeMFGW7BnGvuJ6gQVwLUT9Hk0y2cTvq6isP5VpKUQF0rLffC47M8V0H4P3ioXXHAM@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyOBRf6OWqFyLV/vwQfKTbnrvgYTB0hOgqo1wNWO3XQ5//0eUMh
 kky67tm/qUwz44p+ludRSoHSMkHEFFCWJNSlWuKhvy5X/skqwYV74ZpZIEFQ6n4mCjHuzzsivNn
 alGCJNuQYxOFsmeycvhz21oS8lYfgQMe47RYoatsU54ArNmjxexftHk7mrXqAjB0qGigrGZM+54
 xOjCNeCGAinA==
X-Gm-Gg: ASbGncskcai45Dtf4Jz3a9dXtpIxBTGSpA1oNfJY/WxYkEzWicQy6i9tVRPgZbeoNw+
 bT9hqn7nruAz6LUxOTpsy599r6woXTDqqqGP64pMgIg4IwoSwVbFcPLO2ExT9vxa4VpHC4CKZ0m
 ubK7rjfz4LdKotGCc7mbHCiX9KepA+QaADa0YcUEzO05C1ZpaJ0OhcvPddWzv0JGIELKkLM3/25
 4U9ZfN+TJBGeFICSOFo30LoKeK/ia7nCMWAxNXodJF3QN0X35gS8BK/+PNgWZCx0PBuOBK2F2+q
 +aKrEcR9izJMn098XuhLCg==
X-Received: by 2002:a17:90b:270d:b0:2ee:cd83:8fc3 with SMTP id
 98e67ed59e1d1-2f443d71631mr4572264a91.37.1734610558903; 
 Thu, 19 Dec 2024 04:15:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKj8Q9BdoBGW4+XcL83PolilcHLx944IS9YHTz9Zw7rHpSMBE47UXoWK1Dd82IOjYEHShclA==
X-Received: by 2002:a17:90b:270d:b0:2ee:cd83:8fc3 with SMTP id
 98e67ed59e1d1-2f443d71631mr4572240a91.37.1734610558578; 
 Thu, 19 Dec 2024 04:15:58 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2db9a661esm3119380a91.2.2024.12.19.04.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:15:58 -0800 (PST)
Date: Thu, 19 Dec 2024 20:15:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Message-ID: <20241219121553.s24w6rnws6relylc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241202155727.4221-1-chao@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202155727.4221-1-chao@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UZZ_VQfobaixAmhMxXSJeAHshQwSNfoFmJNOevHgjoU_1734610948
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1tOFY3-0001U6-Me
Subject: Re: [f2fs-dev] [PATCH] f2fs: add commit id to
 _fixed_by_kernel_commit
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Dec 02, 2024 at 11:57:27PM +0800, Chao Yu wrote:
> The bugs related to f2fs/00[5-7] regression testcases have been fixed
> by below commits:
> 
> - d5c367ef8287 ("f2fs: fix f2fs_bug_on when uninstalling filesystem call
> f2fs_evict_inode.")
> 
> - 1acd73edbbfe ("f2fs: fix to account dirty data in __get_secs_required()")
> 
> - 26413ce18e85 ("f2fs: compress: fix inconsistent update of i_blocks in
> release_compress_blocks and reserve_compress_blocks")
> 
> Let's add commit id to _fixed_by_kernel_commit in f2fs/00[5-7].
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/005 | 2 +-
>  tests/f2fs/006 | 2 +-
>  tests/f2fs/007 | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/f2fs/005 b/tests/f2fs/005
> index a817d51a..33d4fdb9 100755
> --- a/tests/f2fs/005
> +++ b/tests/f2fs/005
> @@ -11,7 +11,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit d5c367ef8287 \
>  	"f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode."
>  
>  _require_scratch
> diff --git a/tests/f2fs/006 b/tests/f2fs/006
> index a9c823c1..c1f8d4ff 100755
> --- a/tests/f2fs/006
> +++ b/tests/f2fs/006
> @@ -16,7 +16,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 1acd73edbbfe \
>  	"f2fs: fix to account dirty data in __get_secs_required()"
>  
>  _require_scratch
> diff --git a/tests/f2fs/007 b/tests/f2fs/007
> index 6451d4b4..37388433 100755
> --- a/tests/f2fs/007
> +++ b/tests/f2fs/007
> @@ -11,7 +11,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick rw compress
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 26413ce18e85 \
>          "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
>  
>  _require_scratch
> -- 
> 2.40.1
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
