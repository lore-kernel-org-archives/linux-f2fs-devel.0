Return-Path: <SRS0=weNy=KU=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD397C2B9F8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 May 2021 18:17:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6217A61404
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 May 2021 18:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6217A61404
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YWOz5+YvY5HkSC6uAwSr56vVK0U2/YmQM3YLDtVSB7M=; b=fZspUXyhX2L9N1pqeRUQH2KBt
	J7GqIA1dnBdUffXnH46zXQQO/IoJHxWP86xurq17DFbFQOddwUCdvZM2iN7YXy3WpFN9QX1kQH77g
	sAD6goK9/Ppmw4kiBh4UTVEV/nzJWhuCuFTDULJ9Wau2CsGNfx6V2SZhBINqUCCzu6tTk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1llbc8-0003P2-2s; Tue, 25 May 2021 18:17:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <satyat@google.com>) id 1llbc6-0003Oa-8s
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 May 2021 18:17:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WoDug4+CXTtAZ7sweqscjf9FzzuoYDrpzUh3duNxd0M=; b=USeMObSFINztag6iBuJp62/Oka
 YQ4+ywY0IulD38MJgCCaN9JKNuU6dmdLLdMrsSFhOWC738u7fw3lDo+a3EkAhUDfPzJaJgU9jy1jD
 djJ83nEaE8Oqz7LprvYvNjPHQU0SVK3qDmipdjpm+OZei/Fj3y0nqAixzWYB0H4m1W40=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WoDug4+CXTtAZ7sweqscjf9FzzuoYDrpzUh3duNxd0M=; b=ZlYJn2n/I5ftZfpdvyQlM4Xh5m
 230mQV+/EnidhP741PTBz2YnWWk3Urnmv8oDi2PoDR4bkNnGExPlY+eJB6Co/PLBHsXc3X0/HC9Jn
 30pSolP96DrDfUvLG5djeMoHQBVPxa0aa//b8cf6eUHXgt+5BGqzvcciM8I/TUwMuCts=;
Received: from mail-oi1-f179.google.com ([209.85.167.179])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1llbby-005e9l-GD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 May 2021 18:17:12 +0000
Received: by mail-oi1-f179.google.com with SMTP id z3so31135211oib.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 May 2021 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=WoDug4+CXTtAZ7sweqscjf9FzzuoYDrpzUh3duNxd0M=;
 b=Oi4ypauTpMTlbTHsjemSt/xTEJ/+9zAG69V7Bhfz4Ayw6ClXRcKNt44XVMLGCbhqsX
 XbEbUlylWlOhH8C0b40HQ5uKQmrzfduQmKMgiYMHbzM504zzscb2JaCHcyTBnyU3etmn
 iK2tkyAGMRu6Ux85N9WS/eFtPulNm/AU3nSXJb1E594u4tROoPYT1oRbC1doBf4ZsY0Z
 Esp0o73MzIi9i5OY8+7UeNmm1mu0SrW4gyq9NOR09EUQHs/T3ZhxKLmLXCw91X/jZ/W4
 GoDWITmSMH8TEfYoZWp6aOJ6hKSuUwJDSSRal+LvcixOXl22h4cDq9MTV1HBuyEnw10V
 4/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=WoDug4+CXTtAZ7sweqscjf9FzzuoYDrpzUh3duNxd0M=;
 b=t0JOwu1AbuOndfKuS+o5KIh7xTmG153KAsDM3xHHhJF9Mo0W04h0xcxbkmq9dhaN/l
 3a28P/n3GNpQtXejK2p051JuSW8HadpHbxP90gRlVDQPZIQImxDeZcOP1w112SZi4iiG
 jydSZqRDFrONFylQz08BxXWYl48TwnQJEgzoKJM6yY33yblmMwYW6Li9U/LNne1371Mb
 zATM3dhTsDWt1BHiID2+CjrikgC1fUrA3mivbufW2ztiGT7mT33thBeOFz118rith4T0
 w+S9JdEwZn8LqNdjvODXMT9UGrd2kQfk9dUe+zgdGqvG0F15v0/vK5Wxu/amQmW9GqNJ
 Kabw==
X-Gm-Message-State: AOAM533lcEJcKmviR6JNXDgiS74QcD+73UUkWvmxwKL2BVpgZuuNu1W5
 wkB/CKI1rsIxVe2fXB8XJ8TbBL7MnpmqtxaL
X-Google-Smtp-Source: ABdhPJwZUZIrJ4p4qUHQ1CeHU6I/SbwijQWPeFZemxrafZqwOWR1QtCnvwxuT4le2otbNgRg2XMojw==
X-Received: by 2002:a17:90a:8a07:: with SMTP id
 w7mr31786769pjn.192.1621966204387; 
 Tue, 25 May 2021 11:10:04 -0700 (PDT)
Received: from google.com (139.60.82.34.bc.googleusercontent.com.
 [34.82.60.139])
 by smtp.gmail.com with ESMTPSA id n30sm15154975pgd.8.2021.05.25.11.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 11:10:04 -0700 (PDT)
Date: Tue, 25 May 2021 18:10:00 +0000
To: Lee Jones <lee.jones@linaro.org>
Message-ID: <YK09eG0xm9dphL/1@google.com>
References: <20210121230336.1373726-1-satyat@google.com>
 <CAF2Aj3jbEnnG1-bHARSt6xF12VKttg7Bt52gV=bEQUkaspDC9w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF2Aj3jbEnnG1-bHARSt6xF12VKttg7Bt52gV=bEQUkaspDC9w@mail.gmail.com>
X-Headers-End: 1llbby-005e9l-GD
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
From: Satya Tangirala via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Satya Tangirala <satyat@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
 "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 open list <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVHVlLCBNYXkgMjUsIDIwMjEgYXQgMDE6NTc6MjhQTSArMDEwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+IE9uIFRodSwgMjEgSmFuIDIwMjEgYXQgMjM6MDYsIFNhdHlhIFRhbmdpcmFsYSA8c2F0eWF0
QGdvb2dsZS5jb20+IHdyb3RlOgo+IAo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0
IGZvciBkaXJlY3QgSS9PIHdpdGggZnNjcnlwdCB1c2luZwo+ID4gYmxrLWNyeXB0by4KPiA+Cj4g
Cj4gSXMgdGhlcmUgYW4gdXBkYXRlIG9uIHRoaXMgc2V0IHBsZWFzZT8KPiAKPiBJIGNhbid0IHNl
ZW0gdG8gZmluZCBhbnkgcmV2aWV3cyBvciBmb2xsb3ctdXAgc2luY2Ugdjggd2FzIHBvc3RlZCBi
YWNrIGluCj4gSmFudWFyeS4KPiAKVGhpcyBwYXRjaHNldCByZWxpZXMgb24gdGhlIGJsb2NrIGxh
eWVyIGZpeGVzIHBhdGNoc2V0IGhlcmUKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxv
Y2svMjAyMTAzMjUyMTI2MDkuNDkyMTg4LTEtc2F0eWF0QGdvb2dsZS5jb20vClRoYXQgc2FpZCwg
SSBoYXZlbid0IGJlZW4gYWJsZSB0byBhY3RpdmVseSB3b3JrIG9uIGJvdGggdGhlIHBhdGNoc2V0
cwpmb3IgYSB3aGlsZSwgYnV0IEknbGwgc2VuZCBvdXQgdXBkYXRlcyBmb3IgYm90aCBwYXRjaHNl
dHMgb3ZlciB0aGUKbmV4dCB3ZWVrIG9yIHNvLgo+IC0tIAo+IExlZSBKb25lcyBb5p2O55C85pav
XQo+IExpbmFybyBTZXJ2aWNlcyBTZW5pb3IgVGVjaG5pY2FsIExlYWQKPiBMaW5hcm8ub3JnIOKU
giBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKPiBGb2xsb3cgTGluYXJvOiBGYWNl
Ym9vayB8IFR3aXR0ZXIgfCBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
