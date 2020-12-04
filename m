Return-Path: <SRS0=i1FA=FI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B27FC4361A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Dec 2020 07:02:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDE3224DF;
	Fri,  4 Dec 2020 07:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDE3224DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kl56m-0000yh-8H; Fri, 04 Dec 2020 07:02:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kl56k-0000yS-Rl
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Dec 2020 07:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DGtZLLbFDWoCQqYx9LfvjHPyF73CfxgpUXIf4y83koQ=; b=LK5qKc7iVEJkHuQ8wxpIahGJyj
 L7LxMFQDBoJyvT0AagJmmz7mMLjZnCKTQUgIEPpQ2v3wQffAeSsYzCWVBfPrJDRn7XAoOBgAKxfRV
 TOU9Q+sQqpA14mCQ83+pbE5TiFd2xmDI39Qa9Zar2DOHDnYdXHgqv/3PqLvCB6qxGrhY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DGtZLLbFDWoCQqYx9LfvjHPyF73CfxgpUXIf4y83koQ=; b=im6LOad/SK0gm/R5NXeSDra/lw
 P6ETYrTRpCed8K51WBjPLaepdssNSkd++du4JBZ+WZoB49L8rdFXp+Qa5fwYLR7zaMnC7LzityDNL
 UJZ2V2JOFqN52FLhNIWD8Iux3SwRP8NlcpvWWR0IGa7wxPXFTRH10HcK8l+AeP+utoMM=;
Received: from mail-lj1-f181.google.com ([209.85.208.181])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kl56g-001CNu-Pp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Dec 2020 07:02:22 +0000
Received: by mail-lj1-f181.google.com with SMTP id r18so5438407ljc.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Dec 2020 23:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DGtZLLbFDWoCQqYx9LfvjHPyF73CfxgpUXIf4y83koQ=;
 b=PKdyv27y3AZcNIpFmJN4IexnpXLeYF7dsYQD0hLr6Re40GrmkO6dSIBUQzFksxPrWy
 qnQaRAqgM85WhG4I9zWQzxu1CbBtXf052bshXLmR8KcrOFQ/tIQKFmuTsOrb8ZqC+yyj
 9HwEYGuufCYCuuZsY9BEBI/tY/d5bmrUYc/LfRQpQil7msHn33KHeb7m8ftfYc5oEkqJ
 qV41Jfn0skzideGxiH9UXZILkWCwerJAqj1u60Y3UI/A8G1e77kqiAqbXiWeGcdmbJUn
 fjnffPmoeZUmL8IuMGKce+brMxyVYtbwiCVRD/nKUEhOHT70MK8G0rSunGqISv0e5gx5
 UO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DGtZLLbFDWoCQqYx9LfvjHPyF73CfxgpUXIf4y83koQ=;
 b=ramcj8JkshhDIeMXM0BxoZ/owSrpsjAUyFrQCd8SMpr9YZGqs3YwxgtX2IbY63YYsD
 MBvm4idnt/zIvu1Frs/Ep1J2N0AvKELmp2sot3BNh2m92jML9E+OTxk/+pFC9IWlcl7z
 85ZSc4OrDtNZ6yWMcS7eHD7fJ9RgBXt+qIG2g7HuQ4XV3//4vL15/FdM2/U0XxiKPy5d
 pkhLJDu8dY39l6Anb2UBGAYZI2bgPsjyigCSWVFXWARTjTxnHZXBhSfxpOfIi3Uaw9gV
 IHy/guprUYnynMchHkgye1gveuKUROX5x2sMGbsLFnwp6cmYBOp3AIPx0rglKT64Sad6
 iqZA==
X-Gm-Message-State: AOAM532JRAReq/7ruBK9ATKRwVyfgv198Y2VwwMo4gooXwxOeS6vsARA
 dmikCnynA6pWQKgnWWSYNC7NUHbPGV9J3w2pVcU=
X-Google-Smtp-Source: ABdhPJx03vml2qZJmzdaER4GawRDs1zl5iA2sew69N6FEp9q2vwnZucI8MjZIGzQkHAh4gRehD7/1CHLqBps1MLJDB8=
X-Received: by 2002:a2e:9707:: with SMTP id r7mr2658587lji.265.1607065324902; 
 Thu, 03 Dec 2020 23:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20201204005847.654074-1-daeho43@gmail.com>
 <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
 <X8m0qbd7rvQyiwOt@sol.localdomain>
 <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
 <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com>
 <X8nAParf9GW9LaGV@sol.localdomain>
 <CACOAw_wOShYf23Y0txs6Fk_Qq9JGEjXGRb0MzMxrBxJpzCfLmA@mail.gmail.com>
 <X8nGvfEeTDTLa6FL@sol.localdomain>
In-Reply-To: <X8nGvfEeTDTLa6FL@sol.localdomain>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 4 Dec 2020 16:01:54 +0900
Message-ID: <CACOAw_wfew8xER-CibUtddRKVtcr3k_iGzjQ-bVYxqRUuEVCcw@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1kl56g-001CNu-Pp
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

VGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24gYWJvdXQgdmVyaXR5LgpJIGdvdCB5b3VyIHBvaW50
LiBUaGFua3N+CgoyMDIw64WEIDEy7JuUIDTsnbwgKOq4iCkg7Jik7ZuEIDI6MTgsIEVyaWMgQmln
Z2VycyA8ZWJpZ2dlcnNAa2VybmVsLm9yZz7ri5jsnbQg7J6R7ISxOgo+Cj4gT24gRnJpLCBEZWMg
MDQsIDIwMjAgYXQgMDI6MDA6MzRQTSArMDkwMCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gPiBJIHRo
aW5rIEkgZG9uJ3QgdW5kZXJzdGFuZCBob3cgdmVyaXR5IHdvcmtzLgo+ID4gUmlnaHQgYWZ0ZXIg
dmVyaXR5IGlzIGVuYWJsZWQgb24gYSBmaWxlLCBpcyB0aGUgdmVyaXR5IGxvZ2ljIHdvcmtpbmcK
PiA+IGZvciB0aGUgd2hvbGUgZmlsZSBkYXRhIGFyZWE/Cj4gPiBPciBpdCdzIGp1c3Qgd29ya2lu
ZyBmb3IgdGhlIGRhdGEgYXJlYSB3aGljaCBpcyB1cGRhdGVkIGFmdGVyIHZlcml0eSBpcyBlbmFi
bGVkPwo+ID4KPgo+IEl0J3MgZm9yIHRoZSB3aG9sZSBmaWxlLgo+Cj4gTXkgcG9pbnQgaXMganVz
dCB0aGF0IGlmIHRoZXJlIGlzIGEgYmlvIHRoYXQgc2F3IHRoYXQgdmVyaXR5IGlzbid0IGVuYWJs
ZWQgeWV0Cj4gd2hlbiBpdCBzdGFydGVkIGFuZCB0aGVyZWZvcmUgU1RFUF9WRVJJVFkgZGlkbid0
IGdldCBzZXQgaW4gdGhlCj4gYmlvX3Bvc3RfcmVhZF9jdHggKG9yIHRoZSBiaW9fcG9zdF9yZWFk
X2N0eCBkaWRuJ3QgZ2V0IGFsbG9jYXRlZCBkdWUgdG8gb25lIG5vdAo+IGJlaW5nIG5lZWRlZCks
IHRoZW4gdGhlIGZpbGVzeXN0ZW0gc2hvdWxkbid0IGNoYW5nZSBpdHMgbWluZCBhbmQgdHJ5IHRv
IHZlcmlmeQo+IHRoZSBwYWdlcyB3aGVuIHRoZSBiaW8gY29tcGxldGVzIGlmIHZlcml0eSBoYXBw
ZW5lZCB0byBiZSBlbmFibGVkIGNvbmN1cnJlbnRseS4KPiBJdCdzIHRvbyBsYXRlIGZvciB0aGF0
IGJpby4KPgo+IC0gRXJpYwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
