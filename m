Return-Path: <SRS0=MO+R=IV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B80C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Mar 2021 19:15:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F21619B3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Mar 2021 19:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F21619B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lOmV8-0004H6-8Y; Tue, 23 Mar 2021 19:15:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <krisman@collabora.com>) id 1lOmUs-0004Dh-KR
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Mar 2021 19:15:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lsMVOBWTpDD4ju1pK7beYUXLmwjUpmiaJgnE/GG8918=; b=ESjTym2lEakh08kJYIBzdz5+iB
 /pZYZ9KvmCOidoz1t2uUxIXm9DsharT+I+ru5AbhN7ipeCv8PoPzACVYkWND7438cV9GSYy0/64gf
 Mj4Uzf+0O/QHh6lS8icwJ+stQSYxVI+QABloxcJpQoFHck7zGkGeb5AM3EzygaPK7YWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lsMVOBWTpDD4ju1pK7beYUXLmwjUpmiaJgnE/GG8918=; b=GIHzJTJps8gFe/MsN8slrh5Pj8
 KsrhSnPZLu7ENLU7kEm8w/RYA+6y5LfJvj5e1ahUGKGzx0tCEEAWDQJZXBAEsgkKrLHCvku9bu/fk
 qtBIYirJvBxHDdItqMNAqNERerqeyygZtcpVcKkYyFIwXERL+uwnypQaNrrrn+r2IpJg=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lOmUo-0000O1-R2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Mar 2021 19:15:21 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 7B8F31F44AB6
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Shreeya Patel <shreeya.patel@collabora.com>
Organization: Collabora
References: <20210323183201.812944-1-shreeya.patel@collabora.com>
 <20210323183201.812944-5-shreeya.patel@collabora.com>
Date: Tue, 23 Mar 2021 15:15:09 -0400
In-Reply-To: <20210323183201.812944-5-shreeya.patel@collabora.com> (Shreeya
 Patel's message of "Wed, 24 Mar 2021 00:02:00 +0530")
Message-ID: <87k0pxd6ma.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1lOmUo-0000O1-R2
Subject: Re: [f2fs-dev] [PATCH v3 4/5] fs: unicode: Rename utf8-core file to
 unicode-core
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
Cc: tytso@mit.edu, drosen@google.com, ebiggers@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, kernel@collabora.com, adilger.kernel@dilger.ca,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, andre.almeida@collabora.com,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Shreeya Patel <shreeya.patel@collabora.com> writes:

> Rename the file name from utf8-core to unicode-core for transformation of
> utf8-core file into the unicode subsystem layer file and also for better
> understanding.
>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

Acked-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Thanks,

> ---
>  fs/unicode/Makefile                        | 2 +-
>  fs/unicode/{utf8-core.c => unicode-core.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename fs/unicode/{utf8-core.c => unicode-core.c} (100%)
>
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index b88aecc86..fbf9a629e 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -3,7 +3,7 @@
>  obj-$(CONFIG_UNICODE) += unicode.o
>  obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
>  
> -unicode-y := utf8-norm.o utf8-core.o
> +unicode-y := utf8-norm.o unicode-core.o
>  
>  $(obj)/utf8-norm.o: $(obj)/utf8data.h
>  
> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/unicode-core.c
> similarity index 100%
> rename from fs/unicode/utf8-core.c
> rename to fs/unicode/unicode-core.c

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
