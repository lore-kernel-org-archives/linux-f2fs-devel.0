Return-Path: <SRS0=euTy=YR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AC1CA9EAF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:55:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0447720856;
	Thu, 24 Oct 2019 09:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="OFfFp5+o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fyNfmMej";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NSpJKNmS";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="IpXb8wbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0447720856
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UX1IzJ7tC3hfpxH8xYcduuiJRuVelIpPD+lwfgg0CqY=; b=OFfFp5+oxrwu6y+Onnfh8/1edI
	WzUC7KBQXet7boKu8ySXfgr+Set0rblmjo/49wyeFKVcz6wVkGfynQrONTyO9vGcyWfgnD8RYLiq3
	acCA8UaSLGrmgr+qOEmbBHO5aCEFvOxcQTKc1U17jgbOv6muwtPPpgXr781TfPJJHVug=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iNZpu-00009S-LJ; Thu, 24 Oct 2019 09:55:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <paulcrowley@google.com>) id 1iNZpt-00009H-K5
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Oct 2019 09:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9wILYHfyzdPkt0/hYfDZOYs+W1i9jhuC4WjjgM1Si8Y=; b=fyNfmMejzkwn2PQrHLdklpaQoo
 ZccCDjhC7QH2rZka+ZQW8hGIzV2rtQpnQGX5iiYW12xx4J8VANBj0DaciIRSlLnIxrXdVlEzKlmf8
 yaXMc4sQ8Vjchv5RjXOVsM6hfb35dwRw5gmqWS4i6U0c+wvFB96QlBZ1SGRNdjQo0WWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9wILYHfyzdPkt0/hYfDZOYs+W1i9jhuC4WjjgM1Si8Y=; b=NSpJKNmSea8S6eF4wm01OkJML0
 imI2Sx21tGMRJcpl/l8YH00T+u9sQ8Pgu4JSl24L3x7EfgCeZOaM/Q5zu74hw/Zui9qZZhzIkgeQ7
 Z55vC5vEiGbcHFdoDDXbWewx9iM9rsHRg2z56VG8kBg0gGwrl7XWCuh/ld7Bp3PR/cDA=;
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1iNZps-001Mg2-7e
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Oct 2019 09:55:17 +0000
Received: by mail-lj1-f193.google.com with SMTP id y3so24311949ljj.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Oct 2019 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9wILYHfyzdPkt0/hYfDZOYs+W1i9jhuC4WjjgM1Si8Y=;
 b=IpXb8wbqDIysQMcczI3Yhg6ndMfUC/qO1n2oh1pfqBfcaSOjBY2M4hKGJOc1beCq5D
 1fEZ2xbxlTsQeDEZr1G04sZ4kUKj+ISehO2bczEcDmBRsRgQmnK6F7kioRcZC37cgrup
 vmRxaH1xcHO4QsObdDcLDt+tYY/X4NO0WmHkicCBgQTFWjaznJKfCbsJFLVWjKIGe9cK
 vkl0O8N5++mRgHGnPL9/E2qK+jjWF3KJaYmuOe4Au2F+sLZCEmRmqhc2IKIXfHDhS9Ha
 FitG0+ImgGaFwDTXsKfr5aGSPJetj+5gOSL7Iz1cYHO2WfngX3+RO1VjDcTzc1qP8bvl
 89uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9wILYHfyzdPkt0/hYfDZOYs+W1i9jhuC4WjjgM1Si8Y=;
 b=dG2vmDMCKRJB9py38IVVgrzFEvB14eRgDyGSSbcDYV69xXuWBHqV6P2bM5GTds3y2P
 O4CyoLHcf+Y5bi2NU8b4BWTU5/3v0ROoKtQLeqpvH4E4Rl07ueVHz2f2udBVZjiQwIPi
 N7oQcQ8n/WNBYML9B7l4anVWEMnH8t5jbSQK6mCnnxcaIgx5mKJtZzp+qEw/uvCIgjUD
 ohjejHoG/D3xRrkKWBZNcgAgaBlglsulaG3zx7r3f0Pr2IDcyaykf1UIuAGU+5HoP3wA
 1XLfKv/ZPcBp+UhEfvO5sO7iLawG6S7f6txC1ed6sOzeeelcUKWPhXpViHJ4PAqj5gq4
 G+jQ==
X-Gm-Message-State: APjAAAUd2HeRrNoWjskf9iJ9hP+cu7AGrbX2aNYRBZjFKXfEt3Gh+gJ4
 dSo9O+j4oPom3Yam3mWf0t0uBbeWGBa1vSeCae1D9w==
X-Google-Smtp-Source: APXvYqxBv5EsXSTuCFpOoZBFR/UcS+e+e+GLT4cUj9tmnnXozis1KsX31ONH2VX0dK4f4qIMdJE6LN+XlFXFhBblhXs=
X-Received: by 2002:a05:651c:1b9:: with SMTP id
 c25mr24647960ljn.163.1571910908888; 
 Thu, 24 Oct 2019 02:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
 <20191022052712.GA2083@dread.disaster.area>
 <20191022060004.GA333751@sol.localdomain>
 <20191022133001.GA23268@mit.edu> <20191023092718.GA23274@infradead.org>
 <20191023125701.GA2460@mit.edu> <20191024012759.GA32358@infradead.org>
 <20191024024459.GA743@sol.localdomain> <20191024070433.GB16652@infradead.org>
In-Reply-To: <20191024070433.GB16652@infradead.org>
Date: Thu, 24 Oct 2019 02:54:57 -0700
Message-ID: <CA+_SqcAZPETtuEcSkcwiZcRV7QHr0jq0+oGgF=k+M5bEuxKhVQ@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1iNZps-001Mg2-7e
Subject: Re: [f2fs-dev] [PATCH 1/3] fscrypt: add support for
 inline-encryption-optimized policies
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
From: Paul Crowley via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Paul Crowley <paulcrowley@google.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 Paul Lawrence <paullawrence@google.com>, linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 24 Oct 2019 at 00:04, Christoph Hellwig <hch@infradead.org> wrote:
> I think not making it crazy verbose is a helpful, but at the same time
> it should be somewhat descriptive.

What would your suggested name be?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
