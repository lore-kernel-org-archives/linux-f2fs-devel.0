Return-Path: <SRS0=i1FA=FI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E06C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Dec 2020 05:01:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2442255F;
	Fri,  4 Dec 2020 05:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2442255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kl3DO-0001JV-DE; Fri, 04 Dec 2020 05:01:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kl3DL-0001J8-KZ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Dec 2020 05:01:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NB7a1URi7J1NhIdBjSg3g739eJT9Q7vOhVIT0jhMEIA=; b=kanX3H3ewsU1lKw4cJ03eJBH+p
 3S01BoZ9ur+pK3NsPF3kZw/+Q6r0XRpeCBQcaW3DrdS2ZAjMUVZsL+o8BaobmufdSl2nMzcRQp3RL
 xAJoZLKlvZpTfYgCNRdJG7EcDmna5VgrysTlUQeUIOY6I74Xx93IdJuvRKnOwHHpBVqI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NB7a1URi7J1NhIdBjSg3g739eJT9Q7vOhVIT0jhMEIA=; b=eADrPWExJ0KuouQgHckBUKFF0E
 du+kCd545doeqF5QxUoOlBVMjy1QIaUWKtTVloFVh1zsCRQVQn39dHluB6Ph58LY3KIH+zWEEchLL
 CjPlIC29SHXeg/45AqEA8gMzM3YQfSbX62zG0fD2SR0O36JxY6H9Upvm5bO17cn1D6yU=;
Received: from mail-lj1-f180.google.com ([209.85.208.180])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kl3DG-0015TY-LX
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Dec 2020 05:01:03 +0000
Received: by mail-lj1-f180.google.com with SMTP id y7so5140892lji.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Dec 2020 21:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NB7a1URi7J1NhIdBjSg3g739eJT9Q7vOhVIT0jhMEIA=;
 b=na0+RLGiw3vnnbJVf1HfSi0qDJwPYHOpUcGGhPLf8C1AQbhloiewQj5q2CrC+Gh0Fu
 q/8E42G59IAndHZQFwLA68AlryZ8Kv9nf0j25HpU4Aw4Z61hHlp6genfgibvTqNHy+eo
 FaaQXFaxOAG4FXmQaHlP4r5U3ChTANtjPSOEdmEcPsXnd8miWyeSwItkPeYUtZU0kRLi
 45L2yi4PWg1AGDiGaTlQlA/tHMo5cOljDgqMN1qbnd7o9JUSKlbZkWMkBdjZosusBa9n
 CEJl6qaPZyKoOuc7/wLynyNh4+9B8CrFqyNkWshbPYBxZXpiomo0SVMeWm5BbMorUSEg
 FKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NB7a1URi7J1NhIdBjSg3g739eJT9Q7vOhVIT0jhMEIA=;
 b=FqO2nM8VeRWDCsiDNMPyZRmu3b4BxdvWTKVihYtDX1Dlsj8paw6a6u+FIPIpurrv/O
 FeuBxxXhZBSzES1uvSCBoKlmfiyakadYHoFujvsdT/amOgU7GkQWIqFEAguBa5D/kKIf
 tkkKYrjNrsGi03KiAxIH33ZHpku3wUliFggL4bC5oisMphB6yAH/ZMBya5rHeBVuyigH
 aGG8wk7aYD4sTcqL5MUSVdxiOuuZAlXW/ddwyh7lyhCaErcYZtD0stSXjfCf0jPl70Ok
 LiXZ6qmA2w+r6CahnFcLxOgk9xTA8iZQXFhxxmhrtSPXU6GZJLDKExxeJUou3nef63O1
 1CNA==
X-Gm-Message-State: AOAM532xQmLMuzJQf0u38/fCcxon5Tnxvd6LCWt5wLyCGNyv6YDKEhPz
 A0x+kgx351ri5aQNAluHwaBD2x41stZHuo1G0MM=
X-Google-Smtp-Source: ABdhPJw0w4Y4MJAlX+VS7xk9I3surizC/4XweFukPWvSzHL2//jEgEwhQB2iIIMuNc1heJgdXeMgKd9IJ4N+49i98xM=
X-Received: by 2002:a2e:9654:: with SMTP id z20mr2543089ljh.335.1607058044958; 
 Thu, 03 Dec 2020 21:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20201204005847.654074-1-daeho43@gmail.com>
 <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
 <X8m0qbd7rvQyiwOt@sol.localdomain>
 <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
 <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com>
 <X8nAParf9GW9LaGV@sol.localdomain>
In-Reply-To: <X8nAParf9GW9LaGV@sol.localdomain>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 4 Dec 2020 14:00:34 +0900
Message-ID: <CACOAw_wOShYf23Y0txs6Fk_Qq9JGEjXGRb0MzMxrBxJpzCfLmA@mail.gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>
X-Headers-End: 1kl3DG-0015TY-LX
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in
 decompression
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SSB0aGluayBJIGRvbid0IHVuZGVyc3RhbmQgaG93IHZlcml0eSB3b3Jrcy4KUmlnaHQgYWZ0ZXIg
dmVyaXR5IGlzIGVuYWJsZWQgb24gYSBmaWxlLCBpcyB0aGUgdmVyaXR5IGxvZ2ljIHdvcmtpbmcK
Zm9yIHRoZSB3aG9sZSBmaWxlIGRhdGEgYXJlYT8KT3IgaXQncyBqdXN0IHdvcmtpbmcgZm9yIHRo
ZSBkYXRhIGFyZWEgd2hpY2ggaXMgdXBkYXRlZCBhZnRlciB2ZXJpdHkgaXMgZW5hYmxlZD8KCjIw
MjDrhYQgMTLsm5QgNOydvCAo6riIKSDsmKTtm4QgMTo1MSwgRXJpYyBCaWdnZXJzIDxlYmlnZ2Vy
czNAZ21haWwuY29tPuuLmOydtCDsnpHshLE6Cj4KPiBPbiBGcmksIERlYyAwNCwgMjAyMCBhdCAw
MTo0ODoyNFBNICswOTAwLCBEYWVobyBKZW9uZyB3cm90ZToKPiA+IEVyaWMsCj4gPgo+ID4gSSBo
YXZlIGFub3RoZXIgcXVlc3Rpb24uCj4gPiBJIHVuZGVyc3RhbmQgZW5hYmxpbmcgdGhlIHZlcml0
eSBjYW4gYmUgcG9zc2libGUgaW4gdGhlIG1pZGRsZSBvZiBJL08uCj4gPiBJcyB0aGUgb3Bwb3Np
dGUgd2F5IGFsc28gcG9zc2libGU/IEFjdHVhbGx5LCBJIGNvdWxkbid0IGZpbmQgYW55Cj4gPiBk
aXNhYmxpbmcgZnVuY3Rpb24gb2YgaXQsIHRob3VnaC4KPiA+Cj4KPiBObywgZGlzYWJsaW5nIGZz
LXZlcml0eSBvbiBhIGZpbGUgaXNuJ3QgcG9zc2libGUuCj4KPiAtIEVyaWMKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
