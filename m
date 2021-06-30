Return-Path: <SRS0=Ke7g=LY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD23C11F65
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Jun 2021 09:47:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323A0616ED
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Jun 2021 09:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323A0616ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lyWoc-0004M2-F3; Wed, 30 Jun 2021 09:47:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <lee.jones@linaro.org>) id 1lyWoa-0004Ln-Rm
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Jun 2021 09:47:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=; b=movzTvHsHOA5sioGNiWMUT3nmq
 M+Y7MwtiG7QHApr24ABNto69HQ+Kb9TGUenxUfEbuLPMYeP6ry35P9tCcpKPjxd3Km+VG107gUTaH
 ZvRAJclhHI4UINY3tZ8W90x9OsNhMG1JsOMJMG1SyBRaVNegELUNOUTKaFZSB8Q95ag8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=; b=IF09Mk5rGKOyLXYcOOQgRnL5P1
 pLEFoPtgwxkJ/DNbsGXv8BGWxFeJaT5PN7bAQAXUDbTJmcw1GS2BYhmhDI4IH7HPNHvJM8sA5cjjJ
 eHox30AHjqscWUgdnmOyMb+Sfts/MP3o6KkBI2YmLpNNxl5oOQlZwrYcBXrmm7Clj7a4=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lyWoM-004XkX-F5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Jun 2021 09:47:28 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 a5-20020a7bc1c50000b02901e3bbe0939bso1102360wmj.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 30 Jun 2021 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=;
 b=zLTi5aCbnypPB5E3aUA0ZTW2QZ9ElWO1rUMChAnrYkbnv5R1HppvSR83sz83GmhmUA
 UMxwvrtyn70Zd9AoLodBjAgPxIMvZ1UB4cERbwNt9h4ezFzozjlRXTJceovl8itCNtkO
 ZHpCXotz6yp1b1LU/oBZfpMMbHJ9z37zfQLOhI93YEXu77Z1hvbdB1hXccB0ErO3BuRM
 2v2H3xdjL56voJXkKEkXOJouofN6tE6pWAPsziIGqT+x1uxsqXS8aHT7JlV4vp9xlNdX
 RRmNLJxKm6216ZAGJ10+La1loxmhKlUG8r/gC+MQIkg6soAQE9aR2vguk2YO28brVd4+
 UeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=;
 b=X+gbjVpbX3Do4olmbw1uB7HJXfr8pNJz6sZeIX/rXOVXBlwtSdMlhGvZDWnkhQkrSL
 +IZUUn3wcaLih8uc3n7/WP3GYfqSPGOU1IE818pHtdCu5Rlu1CzF7QjmvDl/ePIoZYE7
 WREBlejuWlyPSrFcabVVct6D9r59853mtlvwy8wQF0v0g0w6rKtS9gcmu7AVGFfjLMna
 3CjZ38Lo0QFZKwN86tvHJY6ooToAVsDlLmLnKEy/JBCXoh8kJ7AX2JGhWh7xmkyzLoky
 IBJOQHb9CvKSBBK49wKYTw+bi6CpqXQdgBwVAlOggdN5R+dKgVrk59hqX//YLA2ZCbTM
 0DZA==
X-Gm-Message-State: AOAM53384EDINZz9wqFjSEr0ZcBUQPJJlyzpcB0m4SZqiuCtX49yA+5S
 Va7XfofscvKr9IWmuzZLr+g9bA==
X-Google-Smtp-Source: ABdhPJysgaWNsxoQ1Ekn5yIfyUpjV6tLOTWrZta/4RIlCjFmHAXWqbWe870FTEuNbqmWvtd9IqJeZQ==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr3558850wmd.33.1625046428092; 
 Wed, 30 Jun 2021 02:47:08 -0700 (PDT)
Received: from dell ([95.144.13.171])
 by smtp.gmail.com with ESMTPSA id p7sm8990839wrr.68.2021.06.30.02.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 02:47:07 -0700 (PDT)
Date: Wed, 30 Jun 2021 10:47:05 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Satya Tangirala <satyaprateek2357@gmail.com>
Message-ID: <YNw9me1Fd6Siy18A@dell>
References: <20210121230336.1373726-1-satyat@google.com>
 <CAF2Aj3jbEnnG1-bHARSt6xF12VKttg7Bt52gV=bEQUkaspDC9w@mail.gmail.com>
 <YK09eG0xm9dphL/1@google.com> <20210526080224.GI4005783@dell>
 <20210609024556.GA11153@fractal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210609024556.GA11153@fractal>
X-Headers-End: 1lyWoM-004XkX-F5
Subject: Re: [f2fs-dev] [PATCH v8 0/8] add support for direct I/O with
 fscrypt using blk-crypto
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 open list <linux-kernel@vger.kernel.org>, Satya Tangirala <satyat@google.com>,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVHVlLCAwOCBKdW4gMjAyMSwgU2F0eWEgVGFuZ2lyYWxhIHdyb3RlOgoKPiBPbiBXZWQsIE1h
eSAyNiwgMjAyMSBhdCAwOTowMjoyNEFNICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBPbiBU
dWUsIDI1IE1heSAyMDIxLCBTYXR5YSBUYW5naXJhbGEgd3JvdGU6Cj4gPiA2NTs2MjAwOzFjCj4g
PiA+IE9uIFR1ZSwgTWF5IDI1LCAyMDIxIGF0IDAxOjU3OjI4UE0gKzAxMDAsIExlZSBKb25lcyB3
cm90ZToKPiA+ID4gPiBPbiBUaHUsIDIxIEphbiAyMDIxIGF0IDIzOjA2LCBTYXR5YSBUYW5naXJh
bGEgPHNhdHlhdEBnb29nbGUuY29tPiB3cm90ZToKPiA+ID4gPiAKPiA+ID4gPiA+IFRoaXMgcGF0
Y2ggc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgZGlyZWN0IEkvTyB3aXRoIGZzY3J5cHQgdXNpbmcK
PiA+ID4gPiA+IGJsay1jcnlwdG8uCj4gPiA+ID4gPgo+ID4gPiA+IAo+ID4gPiA+IElzIHRoZXJl
IGFuIHVwZGF0ZSBvbiB0aGlzIHNldCBwbGVhc2U/Cj4gPiA+ID4gCj4gPiA+ID4gSSBjYW4ndCBz
ZWVtIHRvIGZpbmQgYW55IHJldmlld3Mgb3IgZm9sbG93LXVwIHNpbmNlIHY4IHdhcyBwb3N0ZWQg
YmFjayBpbgo+ID4gPiA+IEphbnVhcnkuCj4gPiA+ID4gCj4gPiA+IFRoaXMgcGF0Y2hzZXQgcmVs
aWVzIG9uIHRoZSBibG9jayBsYXllciBmaXhlcyBwYXRjaHNldCBoZXJlCj4gPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzIwMjEwMzI1MjEyNjA5LjQ5MjE4OC0xLXNhdHlh
dEBnb29nbGUuY29tLwo+ID4gPiBUaGF0IHNhaWQsIEkgaGF2ZW4ndCBiZWVuIGFibGUgdG8gYWN0
aXZlbHkgd29yayBvbiBib3RoIHRoZSBwYXRjaHNldHMKPiA+ID4gZm9yIGEgd2hpbGUsIGJ1dCBJ
J2xsIHNlbmQgb3V0IHVwZGF0ZXMgZm9yIGJvdGggcGF0Y2hzZXRzIG92ZXIgdGhlCj4gPiA+IG5l
eHQgd2VlayBvciBzby4KPiA+IAo+ID4gVGhhbmtzIFNhdHlhLCBJJ2QgYXBwcmVjaWF0ZSB0aGF0
Lgo+IEZZSSBJIHNlbnQgb3V0IGFuIHVwZGF0ZWQgcGF0Y2ggc2VyaWVzIGxhc3Qgd2VlayBhdAo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzY3J5cHQvMjAyMTA2MDQyMTA5MDguMjEw
NTg3MC0xLXNhdHlhdEBnb29nbGUuY29tLwoKSWYgeW91IGVuZCB1cCBbUkVTRU5EXWluZyB0aGlz
IG9yIHN1Ym1pdHRpbmcgYW5vdGhlciB2ZXJzaW9uLCB3b3VsZAp5b3UgbWluZCBhZGRpbmcgbWUg
b24gQ2MgcGxlYXNlPwoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpTZW5pb3IgVGVjaG5pY2Fs
IExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29m
dHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJs
b2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51
eC1mMmZzLWRldmVsCg==
