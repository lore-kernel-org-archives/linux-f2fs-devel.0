Return-Path: <SRS0=9+GF=EJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC6C2D0A3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:32:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AFA20735;
	Tue,  3 Nov 2020 15:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="N81VL5qL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="b64QY4nw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrVlj56y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AFA20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kZyIT-0005CR-KL; Tue, 03 Nov 2020 15:32:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bjorn.andersson@linaro.org>) id 1kZyIS-0005CJ-GO
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Nov 2020 15:32:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N71Zs4qg4W+XUXzJvJITvEfPb9AWspIlQairrp1whfg=; b=N81VL5qLSZPJR87WTGjfv05JbB
 9F93qhALuQYLtdzZeyzo+wm1DTcBFuvCnYGPfQn3x9k3xy0iUmD8YcMkQmRpsFG7nRhhILGPBF2kq
 k1kqsuu0TO/YZ4lkgvPM4Qa0BMsBpM4oXs6m3Kbf66Z29ytO3nubUH1t8K3OjRdbpW8E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N71Zs4qg4W+XUXzJvJITvEfPb9AWspIlQairrp1whfg=; b=b64QY4nw9Bw8ae78Ow3g3M+kSI
 VzwasU6M/u3M2RFlVLmsIAMeEvBMIDMwW25A39fIzufoUTOktAXfQEQcv9L4FUPNoE+gs7xe68pzB
 K1tUXVsrb8NvrY0MERFNYoOVeukYuePkWsKgVklmZYpp3zEeHcsGC7v4nBIftfH1+UZM=;
Received: from mail-yb1-f172.google.com ([209.85.219.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kZyIH-007svz-9V
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Nov 2020 15:32:32 +0000
Received: by mail-yb1-f172.google.com with SMTP id s89so15145044ybi.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2020 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=N71Zs4qg4W+XUXzJvJITvEfPb9AWspIlQairrp1whfg=;
 b=rrVlj56yk2trpBYSpi4k2yd1xCK2bo7zfyPwMRTDKgj2zJFZf+rsg3l64hS6mNlXsJ
 /lsnCjsBYlscUhZQjxreix9yr1FDyyJ44isM98ku6PfR5nfH8ewfPGTyJoG+z8DaKf3B
 GC0lFyYci0jWLRuivuAjfzCGQfauYD+FIBoJ65Z0ysgZFvM7r9APNUcj/A/ERVF2MbLf
 yty4WBGjCP2WpSIZHr96/NF2lvOu9gyd0kH5dNJE6T16tbnf8/wDcP2ZEnVaZTeW+uv8
 AOywb/DHyLh7Si/JMqeCh4eS5XqaKQQMWQhjlysMgge2i4X83N4I6vLqLPfg4x7OeC6p
 Yirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N71Zs4qg4W+XUXzJvJITvEfPb9AWspIlQairrp1whfg=;
 b=Rz1+zml5K8ut/jVtWtl/HFnTzRg7/BOiopQMpoTlIreMYrcI0cO8YSES+G0wdFgcqz
 Fl7EjzXl+tqhaXIKK6uxGA8Lzzg9uTEeTHtxuuA0wWH+22qSryD2be8T4DHF8DHD+JPD
 tDEw+WBe70L61D48yUFNt0JBynPb1jTuCU0xMyJ1P3AZ4f+8J/yfvH3o58L4i//tEfCO
 kpyCwsExq2z5P/c7J/q/f54QCgmPpAoH0TUIh0YeDyQh9WajzfwvLmf4/8KvzYZfj/d9
 keV/WBPxlMzS6naDBcWpmcz/TcHusdPk9lI2ImFcn1lDO+GXSut2N+uL7sLN5QdT2/rb
 sjeQ==
X-Gm-Message-State: AOAM5319bCfg77XzVbcCSDQomeDZCO1mYdrpYWrbJsZix3TvB9fmVMJf
 pNuGHYFQWnOEXubgG3nsDmoZm/maWMhQzA==
X-Google-Smtp-Source: ABdhPJwU2NP+qjv7T5X33Bc5Qb64pjBRUiEN1Yk0nWz/TQ1GhwOuIu9xrFu+5vjm7/EyqQJ1LvpBNw==
X-Received: by 2002:a4a:6b1a:: with SMTP id g26mr10661391ooc.13.1604417066733; 
 Tue, 03 Nov 2020 07:24:26 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id v5sm4548511otb.44.2020.11.03.07.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 07:24:25 -0800 (PST)
Date: Tue, 3 Nov 2020 09:24:23 -0600
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-ID: <20201103004241.GD223412@builder.lan>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
 <95ef2cf3a58f4e50f17d9e58e0d9440ad14d0427.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95ef2cf3a58f4e50f17d9e58e0d9440ad14d0427.1603893146.git.mchehab+huawei@kernel.org>
X-Headers-End: 1kZyIH-007svz-9V
Subject: Re: [f2fs-dev] [PATCH 30/33] docs: ABI: cleanup several ABI
 documents
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
Cc: linux-stm32@st-md-mailman.stormreply.com,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-iio@vger.kernel.org,
 netdev@vger.kernel.org, coresight@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i3c@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed 28 Oct 09:23 CDT 2020, Mauro Carvalho Chehab wrote:
[..]
>  .../ABI/testing/sysfs-class-remoteproc        |  14 +-

for this:

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks,
Bjorn


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
