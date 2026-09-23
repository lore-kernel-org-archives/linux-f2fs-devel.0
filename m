Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486DFC9830C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w4OyxVeS0T6sWS7qFief8twNdBkmK0ZBMWkCZhTyliA=; b=EXWQhg97N2CErDmurgPm9vH4kW
	cD8VeevqfuEOiQscvlF4WWiN81o5GkBM9w/86r29Uu5oMYbJGyisrBQ2g6uHQgA5IBsm7Bk0rs/3k
	XjZkGtE4D6zW1Kb3llacok/j0as24qDuFQTYfa8cHJBulI3Mu0q44Q/fj8PaBuqr9Awg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9OBn-000857-RB;
	Wed, 23 Sep 2026 14:43:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x9OBm-000851-QV
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 14:43:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3lo0vWA5oRZ6Lff7JpvPLzIkSLUiQiS++q2tvuZ8MJ0=; b=hEKiKc5otqQ6hABaY97SlSjyOk
 U+k5Zm7bmouCtoXSRXQExm/qJDZVBvQZaCs6T+KqA2XqN4On5ykB0nc+z05wLoLyRSeqsJcPY/wDn
 t2rIFYolGoUbd1xgiva2QswZ02VVBxPcMTSxzspTY85UdoJHHk1txD4GqI0rW/pYZWKM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3lo0vWA5oRZ6Lff7JpvPLzIkSLUiQiS++q2tvuZ8MJ0=; b=LaaCxysuDeiUTUMavdjQtY/7Y8
 zDAsvU3/HpzTaHvArblQSGF3sCyT7c05UisH8He6yQFybYI+8wTOtNFV683V94ODL0hNfJ3hK/Q7u
 pzHOz0Qa7l65ez7f/udjFpktKFEUqE1S2vSsx2JVsBNtSXg+hoavbZ+qKHa4lQmfkZqk=;
Received: from mail-lf2-f13.google.com ([74.125.229.205])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9OBm-0003iU-6Z for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 14:43:15 +0000
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b74dbc7359so901580e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 07:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790174587; cv=none;
 d=google.com; s=arc-20260327;
 b=mBmY79z/qb+aNCQbDhvRD+5dWgmI1eWfm2FLv1eZ5dG6ptpqp2WAmICngItvQWaBe6
 iZe8Jdu+x2HGYevLjqi2BM6pzU0mcQ6ZSe+tTlShsbBiRXo3+v0CAL9bA/+D+qUDOumI
 Pi+MXPj6j7j3XyCwsMmSpigQyY8jFRB3v3Z+LKq+2fVDu1a0GrgzgAZ+iKJOH95OXLtW
 kUtBFpdvHob+RckaaBBvGzyfabl8KOZjeBxFFYXHWYpgMwh5qRIoclcN72iP5gybZSiy
 ofm8oLp+V+rO67QJtpFHK8AAgm6j06PdLCOCT2p3A1kPoFPSiNWQ8QRQArSPmEHrkKFB
 o2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3lo0vWA5oRZ6Lff7JpvPLzIkSLUiQiS++q2tvuZ8MJ0=;
 fh=N3DoRQmEQafijaKd6Vm+Cf7fY0onyHak/AVgEENdGaE=;
 b=HXiUs6mQAzCtHQZ+az7TfJJT419JxOswvHtu7qh43J2d86KS588KBQOcTKjyY1c8iB
 3LJqj8Bi3ZFDMnbmUKZk4H6q81prsFIR+5nm/o2USdYMpTswz5EOZVBCwfUsRuDbJ9c1
 Pa5OtHh70OvgPuiB1+kEPIi02+f1C3pWeMVrr2ZErsvtrLmr1vqy6gTd4EpishuZ0Cy5
 +AMTaCLyLcS+QpumVpCyUB/PRzs8u6hIB4G59/+AjJL2HcHb3U2axOMgMOZs45M1Mn8C
 8EZKJb/A/Y2Ghhywy7UBScu6wyeytUZMmN75THxgBtrdm9bSFkyhHUfQJGD4a2cpMyYW
 4ZGA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790174587; x=1790779387; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3lo0vWA5oRZ6Lff7JpvPLzIkSLUiQiS++q2tvuZ8MJ0=;
 b=PjPYP20m+b0SsM0HAXCOhoje2MrAawhfzrWsblEce1apSI/NAWd3ogDNURWYilCCdU
 LOPw0/RABMWprk2YDMDZnzSTMXjr+2BZcKizct+qq/IvsWUrUZnfUaSXSB7OApq8XEpy
 oWK2+1pkRnBd2wilueSwJAHa1ixcbh7vqzgeUfAiJTMhP2y2z2zw3cE4vNypj6WNy/+x
 F9sFu3BiFzZ9iu2nhUCBg4RUtF9fAWhmaWLCXI41Ezek+cLnCYbsYvNrC9jNDsJdh027
 eeqlpnSs4QAnhdS5v5+j8I8n+kJKBb2ITz1pMWr92m7UIwIGHSGcQJ3iJqrkVUSljfP5
 Z2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790174587; x=1790779387;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3lo0vWA5oRZ6Lff7JpvPLzIkSLUiQiS++q2tvuZ8MJ0=;
 b=NM91mveskwMo3Og4NZWvviQ1ghYwKj5CW3ZO1Y5/lJ+ESBPIaP0obLcCBrYifT5WaH
 rBXVNtIt1Ji11FE622VJvjecJJzSnO5/0vU0hxDzeXb4W/4CuMPbupVHkxPDGjWk9HMz
 qtqnGi8fZYfMcL5PTxjP3WaBLhS2bwrFeJtdtkfj4+8inDftZ594HZcor/dKkcV6BS4R
 HBwZMuIgkcwhrLhA0P8UCqXSIXDFTbs7i0P36bZD2HT/fjySMVCRhB77o3AOcFqR9tvY
 Ncqar6Wf0kVso3xAYtM3bdGAANZTFTZO7KXbeQKLg+iYkshg7os9ySwVu0QGqxOWNmrR
 wfmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKwLYQCRd7SFGUWA4LqQBn1j6TyHHvjmVf/DhHz/UU9BXqc38lNttNz0A0iu+siVmBGhcctiF1FIyXce6nuU0y@lists.sourceforge.net
X-Gm-Message-State: AFuF++lYDlTd47rDo8QEbZM/6Hg9qkLIoTId7oycRTNkDIo2yHf6R+cW
 Z9IiDAvUQ+bvCuCiHTcJoMrH3ZfdXBzw4ft1KIvbYDftqxiBkgrMtYOWAJRcha0eJaA/3cL28qu
 CFnIo/+SOFPPJ60WU1tU/lj/QxIsoGmc=
X-Gm-Gg: AYBFou0WcgDI+rSvznD6DpRJ6CMLtCYby5gTsmFwQJh6ldtK3Q/Pu3MkGXEjtAuY9FO
 qA4N5EXh9odpM+ISq0CMTfE992Wfxx4WMCAwrOhwjg2evmQPCxSHVm30yA6XytTPZPccRpexFTn
 a1VOmiayn0gGo1+L1R09mwV57L+0J1Pqw3Xc9WVGyjFAn2ySujxJRIBQ5R3V3KKtiVlrtfIYy3m
 ZtSRqwVqVa4fYwIFsWhPPNg6KNJg9ECFXjpaFzjsJzwfHEcwC3p6hhhoMdLTsY12juULhVJQxJX
 ohiBW86Cckt3ju/0ioWhiiGbQSi3tPdY7nIXgEEum2XLYY7d0B8YXAWjrc+eM4nDf3Nuhu0rKVP
 FFTIUXyCkgj2b69DSKg6I8vvowcMmo5pjcXhBYwBKRhk=
X-Received: by 2002:a05:6512:3d14:b0:5b6:1a7c:59c8 with SMTP id
 2adb3069b0e04-5b8d89b80f9mr980031e87.34.1790174586551; Wed, 23 Sep 2026
 07:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260916060610.1098289-1-ke.li11@transsion.com>
 <20260923091913.1152395-1-ke.li11@transsion.com>
In-Reply-To: <20260923091913.1152395-1-ke.li11@transsion.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 23 Sep 2026 07:42:54 -0700
X-Gm-Features: AclHuK_9VYtBvPf2DmT00IOoQvhoE0UtmL0uxmesevvtT1-VqFQmAE6b_skf1UI
Message-ID: <CACOAw_yuWVYFDktwFdjTVV8ZmspUJ41TVp=YW4Z4Vajj4oMoXQ@mail.gmail.com>
To: =?UTF-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
X-Headers-End: 1x9OBm-0003iU-6Z
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: multi-device expandable storage
 support
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
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgS2UgTGksCgpJbiBteSBvcGluaW9uLCBjb250aW51YWxseSBhZGRpbmcgc2ltaWxhciBzb2x1
dGlvbnMgdG8gc29sdmUgdGhlIHNhbWUKcHJvYmxlbSB3aXRoaW4gYSBzaW5nbGUgZmlsZXN5c3Rl
bSBvbmx5IGluY3JlYXNlcyBjb21wbGV4aXR5LCB3aGljaCBJCmRvbid0IHRoaW5rIGlzIGRlc2ly
YWJsZS4KClRoYW5rcywKCk9uIFdlZCwgU2VwIDIzLCAyMDI2IGF0IDI6MjDigK9BTSDmnY7nj4Ix
MSA8a2UubGkxMUB0cmFuc3Npb24uY29tPiB3cm90ZToKPgo+IEhpIERhZWhvLAo+Cj4gR2VudGxl
IHBpbmcgb24gbXkgcHJldmlvdXMgcmVwbHkgYWJvdXQgZG0tbGluZWFyLgo+Cj4gV2Ugc3RpbGwg
aG9wZSB0aGlzIHNlcmllcyBjYW4gYmUgcmV2aWV3ZWQgYXMgYSBuYXRpdmUgbXVsdGktZGV2aWNl
Cj4gY2hhbmdlLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgYW55IGV4dHJhIGRldGFp
bC4KPgo+IFRoYW5rcywKPiBLZSBMaQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
