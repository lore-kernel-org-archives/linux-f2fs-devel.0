Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A75EF5852
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Feb 2026 20:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XHldTDUKm6ay1/runGAVTuxl7D2KcroB4JmCVRPqM5g=; b=DtnnAAcuL9vykTxi24De42OTpn
	vyPcZ/5hoBLXOZx1CuFWg79bcNamnTVOXXFf9/7pGSaiFA9YkZwBUN5+Sot9hXqKKp1b8HVwAXWVx
	0NuQRFBMoSQZEhNnMgcO+3bVth/wCjAYiJuQABKSvpDgrDI4NBQ+GYeOj69lkinxALp8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vrMQd-0007ej-BI;
	Sat, 14 Feb 2026 20:39:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <torvalds@linuxfoundation.org>) id 1vrMQb-0007eW-FC
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 20:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xobni0Kui4RUZeyiNPg7YdinYh9j2rSDgpyUC3GHngQ=; b=RmDpM6cv98L61zEsxnQ8kzGNjV
 Y8eHicMmJqmHlyNAwrxezi5OS38x21Mih9cr8Xr7jN7lb8b1Q2fh6Dg0DlFgBjE+dxUluMdA9oCE1
 DMtDnNmB0CXMRW+MGcjFKXmHsRtn/+WqDgiOQipe2T2HQwQS3GWtG9MasM3rCWr331Vw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xobni0Kui4RUZeyiNPg7YdinYh9j2rSDgpyUC3GHngQ=; b=PqIYhygTmWvT78er0G8DY3wK9W
 z1TaJPrHthqSVHzOmnps9UCkDNrJ6B4oZJ2lfBRifS95kB5CL8N3qc5K+AyUrmoM3yOXx5XR6AxEK
 o+s6hAh0kp2AawgbMxKEtO1U2qjvHXvsxByFmW+PMmKczyto7DfAb0T36Vh4Fi6qtIrU=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vrMQb-0003Bp-LF for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 20:39:46 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b8845cb5862so263110166b.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 14 Feb 2026 12:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1771101579; x=1771706379;
 darn=lists.sourceforge.net; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xobni0Kui4RUZeyiNPg7YdinYh9j2rSDgpyUC3GHngQ=;
 b=ei/7tovLyuey9wPnpj0GU6pxn4P2aKl71PotkajAmvCgGgNU1QMtfaIW7XH5iuwfky
 Q+hn44eX5H0OVIzUUrLnQy+iMEH5/0QcDFnVXerPfjgWI8e9DuSKqqUbJ9tWEz71ccAY
 KIcRvJ52hTheeQpezsgBK4KKhfbYpl/vSDT/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771101579; x=1771706379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xobni0Kui4RUZeyiNPg7YdinYh9j2rSDgpyUC3GHngQ=;
 b=aTNemrAUEmF1gjR4rALjgpOFBtzK9a8mMXG/NwaA/jOaBYP2F2NdB+7VQtyaeitCdT
 AFYNDglLyuRjwwm3f5I0IMNm2OyYVHxO7gYq6YC7QRkWt0eZp9RbGFO0ydbPuc5+lUoJ
 nQHC8hBzOYALLxaoQNrJjujY/CHBTe6KO01rCgp59UHHRXfjWxz/oMCiQJd0y1GOgEP7
 kNA+plYbOpCV/v/MvsJxcgereHpb6aE99jwCNy+CPuikHHrAdpBcdQGWc9+XA/dbKEOw
 8lE/t5uSz8PGcO62GI9jrnLqPtn1deh5N0y5CsqseDPJE1/XKz3qDBqnV/CLWibqN9Yr
 91fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjyusQ5i3P54yOse6Kl1q9EV9fGyVdncITTJzkIThfvIVEuVaeT9x+41dRKaYbgdniWE/i9Z514g5pLre+aW9j@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxreW2OMWG3+t7hf0lBQYUeNG967mrtQHyTLXTlUs7K120m2rjj
 KRZKBOjAJbQsKbVppH2JKTrEs2VjE/JkoEppUahRqjUXMw+pAkKVjgFM7/eAqipcHBJe9+x4gBu
 OqwnFbAE=
X-Gm-Gg: AZuq6aKdSgBdFgaWIzaXRjBIE7ZUSDUr7ZeJqJoTYPsi5k/arIy/2/M3XepPJhZjfCQ
 606PwRkIwT5JE1YW2NEsHlrb8rrTvSzAYmE2vjf/iTLih9vMZFDXY05pOs6TFJkdbBS/St+40Yu
 mPUJoxUO107ybQf8IOSNxg/UL/NvIrQmccNyeZ0tJsGZvH8afm+INr7GWEGyz+0ed0ntQz9woQm
 iu7Iglj3wGcYjJZQTXv0wsG/XI+zqsNqgcEIasC0v66H2rVRK30JH1ud+GxCbz8XIdebpuNkwaR
 ri5bDQp+hFWQaFEh5c9jryTamdhRQgbfpYbZxgwBbs1CJLh5SnGvkoQm4P8XNsMAwU8Dpd1RsQi
 kyXleC20od2AAF1ARvUiuwUZe0hZpifk20Jcf/YDbkyoVnqPR2TersOZI0Z/q41v/gAHx8OthGa
 CzfI65acmSqtbnz5vKIgA5RmoQTBL6NTZni3BdRTtJCx//nUdLle4AioGL53HqPhoQ5ujlIn+8
X-Received: by 2002:a17:907:1c9f:b0:b88:9760:2df9 with SMTP id
 a640c23a62f3a-b8fb4147096mr305185166b.11.1771101578962; 
 Sat, 14 Feb 2026 12:39:38 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc76c7015sm95471566b.66.2026.02.14.12.39.38
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Feb 2026 12:39:38 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-65a26c220b6so2765678a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 14 Feb 2026 12:39:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW8X5FN5WrVlvREBpwi1mgpGJoZf+QjfYZal5zC3Xbks53OSQw+1eSNIAjgFg435a9tKnLOwqUwCT8WyshQI9zp@lists.sourceforge.net
X-Received: by 2002:a17:907:3d52:b0:b88:16dd:d835 with SMTP id
 a640c23a62f3a-b8fb4149eaamr307827166b.1.1771101578249; Sat, 14 Feb 2026
 12:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20260214203311.9759-1-ebiggers@kernel.org>
 <20260214203311.9759-2-ebiggers@kernel.org>
In-Reply-To: <20260214203311.9759-2-ebiggers@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Feb 2026 12:39:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi60UWZ=kVayGKfrGURiX4aN6P4J_bNMOw_pSvUrxw1jw@mail.gmail.com>
X-Gm-Features: AaiRm52N7qTCMNkbWXl0IrwYY7YFxDkuplThSymslcU1mI1J-WYgkUTlm-Kk_bI
Message-ID: <CAHk-=wi60UWZ=kVayGKfrGURiX4aN6P4J_bNMOw_pSvUrxw1jw@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1vrMQb-0003Bp-LF
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: use fsverity_verify_blocks()
 instead of fsverity_verify_page()
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
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, 14 Feb 2026 at 12:33, Eric Biggers <ebiggers@kernel.org> wrote:
>
> -               if (fsverity_verify_page(dic->vi, rpage))
> +               if (fsverity_verify_blocks(dic->vi, page_folio(rpage),
> +                                          PAGE_SIZE, 0))

This really is very wrong. It may be equivalent to the old code, but
the old code was *also* wrong.

If you use "page_folio()", you need to do the proper offsetting of the
page inside the folio, unless the filesystem is purely using the old
legacy "folio is the same as page", which is simply not true in f2fs.

It might be true in this particular case, but considering that it was
*NOT* true in another case I fixed up, I really don't want to see this
same mistake done over and over again.

So either it's the whole folio, in which case PAGE_SIZE is wrong.

Or it really is PAGE_SIZE, in which case you need to use the proper
offset within the folio.

Don't take the old buggy garbage that was fsverity_verify_page() and
repeat the bug when you remove it.

                Linus


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
