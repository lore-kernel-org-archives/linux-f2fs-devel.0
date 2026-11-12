Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5B606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BnXrjc5l;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m5vu6Vh+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W4KM6xnK;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qbUp1/2W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=UfRdQtmimLDl7fV6A9PxuJXSl4EeDGRYQElAv7b+WI4=; b=BnXrjc5lSWpk/2sRkji87cwhEm
	hG6Qy9iCXnmJs0QfYGgvpurZW2GWOcMCIRvj/hGdwvdHubuCJlAk5yHji2KFFtzw9xIT+FIhcxfoh
	ClJCDDh2JEqUig80i95s10G1ThMAt/G9e+AlE+IMO+Iqwha45N1nQaBhuC4TvGXYgUlQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRLnb-000000001O9-2Mdy;
	Thu, 12 Nov 2026 03:48:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jsjlee1020@gmail.com>) id 1xRLnb-000000001O2-0IhB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 03:48:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KhSncitynV2ttbkta0+XeVmF6scMEZkRXU25IseA/fY=; b=m5vu6Vh+n3NxBt9hsGFhlUFkPK
 oHsh6VIPrfE73mvGItjuphiYDuDpyXWgtGvFoJJnitqBcuChmijCAQhQ7AsidpMCaU7/W4pTnUJej
 xxfveYBe+RhRMh0SKuWCj9QsVd58op0+CC6pDj4SpqnGfwTQn2qf3liNXUy2TmDo4S4k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KhSncitynV2ttbkta0+XeVmF6scMEZkRXU25IseA/fY=; b=W4KM6xnKyBLWlWrgdOwHdYjZUh
 xeE/JjhdEZKT5wCnEd/3bi1EotNeiP+VikWzh+X/fmSlM/fbl57cw+YLtCiiBD50iq/MgWRiOOyxe
 u8RHNroI+TsRIxeoK84jZaKqxgm/xxX/RizdEAqKAdBNBiQhQzcfOoY3KQiDkr6OI8h0=;
Received: from mail-yw1-f176.google.com ([209.85.128.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRLnZ-000000002fb-32EI
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 03:48:30 +0000
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-8b32bbd39d5so31469907b3.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 19:48:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794455304; cv=none;
 d=google.com; s=arc-20260327;
 b=WTthD2SIgKHCn8TjAfVvzI0dfNVqIQnlZVKFiiNuqfdbfHynMl30a3UkDF5Pry/Dr6
 tksgs0A9g/5QXXCcutvZZyHF4oKn+wJ8nrZGG8XG6jaUdEVp48WybCppCPPPzu1K9BAS
 9T7bUCH8RpwPCzpTSqybYgsCtvaqu7hjik01jFadXFNO+u9SwFjTeAPYuf3Xqg6ptwmT
 REuqxdan4dT0xLnnu19TRuZb59oas7THCSnUVxtyyc7+RIpe49xhQd1p+3W7RF7sB+HO
 Hn1uLIu8PjPZYaqZSckfgwYngGH0l3VU0aHlFXUqK3194yOG7muqrV9aBoKK9gi1aRrV
 R0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KhSncitynV2ttbkta0+XeVmF6scMEZkRXU25IseA/fY=;
 fh=8J/FBad9Jmf8pIJx+q34Zj70fE2SfLXwfpTdSUnGYBM=;
 b=NRuU3KJOiOP+wwocNAAT0sdzUlGkPaaWvowwsmILagzSooKLCJg3MYfmxLMzGfvlIj
 B1iyoyLP1n4dg46A14FWF3pc+E67NNOnhQTRoDu2WcmVYYe6FIo59e5lj792U5OEqHXk
 Zni02hfVp/VWben6iX5t5xmQFG6ekCFm4Bv+SWQuHjmgfSYAcSdBm2PQHXGTLa5PmjfD
 8I9YgqVKnFmuINkiinD6aUN0NAfIDjpPsVwCS2ny2y0SXnsI/ogouDwb3dU+N/yoy44t
 REvsmjJHwg6k+sJsg6nlrMnSXDq/C6dhUppJaSP709SJHCvTyCW2hB65txGRgb0bHQnv
 nNbg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794455304; x=1795060104; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KhSncitynV2ttbkta0+XeVmF6scMEZkRXU25IseA/fY=;
 b=qbUp1/2W9t9GW/BYtgAcn7mUK5UfqOGWVPw/SVomZO3uvUReg3ahufmtg0eB8GiHwa
 fuwoBfQvR7RKDmwSD/wKuQz2nMCqGpLJzgYtI+2235q4wJIISrnD9og83VZ3lrDr1Nun
 XhWmxkoiIQGaf319K/cDRjkfURp5/ChlC+ztfePIGlGwqlkHczDMeBqOshzP92F1vrx6
 jBqp0o//BTKDsPEGmLWx5C2ABkIyjDpcnC60Hs6qMWRtfjWR23A0pmZgniQsLnBL4J5S
 lKCO3DvBgzk0S11ZxSXeX8auXiS1hQ2U7avvZrIE6FX9b6PMiAV0HKhoRicANOxWyZ0X
 hidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794455304; x=1795060104;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KhSncitynV2ttbkta0+XeVmF6scMEZkRXU25IseA/fY=;
 b=Fzx1+2ixUZT0pJ3IN5bRWSFvEevkTdEsBDYwZfzqpFfJhH7zOpLRUPwnHprJonDy/b
 rIQtA953AraCOYtiLiq5dnXZa9YxmdRHV8MtzUjG+OJosFkqwcmC9EoKmTBa6BFvr1wx
 ga+FEklRb2h5jj9ZzBbWMOOC3jQE2Msu7nIUR0/RtuQWiJr6Xa31ZWmOQ69FqMf1/Oak
 UF/xLTzSPOGQcemBxE0XrkqzoqgmEp1i22iI9B7qABL/LAbRMcZR0xDCgs5epRyYmiha
 5GxTG79E/3cQOAanA/jMmPz1jaQKcx6NvpI60I/fABAVZsiKQcgQOiX+EL+ZxxVuGOlM
 NPSA==
X-Forwarded-Encrypted: i=1;
 AL+hErF8g8hM0+HHyBi5NZx4j+1LIBcjsN+LU9UX/u7+0+PT3fy/wAa0VqiCYn5kKnmaAOVDBlmxxL2sg8dloWVIyJ/f@lists.sourceforge.net
X-Gm-Message-State: APuU4Z89CpBPoNdQezlORQ6a8xUuZueuVw3SMbAvBwoO9J/dt52zbFtW
 Bsmn2SYXNkwwOnThAqFzt8TsvtU86DsBk7E3Xl1zWNKfuUlNKlhAplQuJz320eGDtxZjUFp1JrR
 NvhK6c3TmQbwSjKxQBDGNRanwIQ42KSDoCU/2
X-Gm-Gg: AYBFou3hTVbLf+Mumj8YLWX6TWSUffGWflNuthdY9FcMoPJ4eaYX7EJYsg6RZk8Hcwo
 oOiEUtbfxhKIe3XfMp9Rp0uJG/jbiec5UOlWJKtsWYd1IJOJFhBDaD2KMibrKrZ2Hvjituw0sM2
 gNxxIcqo7JMmws8BhfpnjiLqtKFpsNUqnFHg9Bh2KBrDSQXC2PMpyPKBrrNHXx0rnlyacD5M59i
 i8YjCJwW+Ba1gPYNIT5PlGllkaPlSh9WNzFnsan+viWodTgMnSchVcVv6rzeXFtkLvAU3PMRL2F
 We0ooxSM+X8EBEEqJsDhQuG26KWdtoFZeNmx/d0RrFn2PGxdMvtRy8h4bjgrD25ddzyLJOfBlPs
 P4tl00k9tQrWfNbTfY8cHRvWJNh8Ht2E17R7NZb4qIyalgitMDF6lXssZeLA=
X-Received: by 2002:a05:690c:7013:b0:8a3:7828:58b3 with SMTP id
 00721157ae682-8b3a7dba933mr39348317b3.7.1794455303703; Wed, 11 Nov 2026
 19:48:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261004061007.7433-1-jsjlee1020@gmail.com>
 <f3f5fe2c-f0f5-4c23-a2f7-6cb5e09ced5a@kernel.org>
 <CAPHXVrzaWHYccYe+PWLeAf_N3md8ens0UsW7aH-047KGhM4BUg@mail.gmail.com>
 <102da404-ab62-4ba6-b46a-1846ca64c72b@kernel.org>
In-Reply-To: <102da404-ab62-4ba6-b46a-1846ca64c72b@kernel.org>
From: Seongjae Jeong <jsjlee1020@gmail.com>
Date: Thu, 12 Nov 2026 12:48:10 +0900
X-Gm-Features: AclHuK-UZhDlBHmuWszdjabS_-A-QxzVVRbwjWQK-vw6pJDf0jFFjAh-PDig9Cw
Message-ID: <CAPHXVry2O-AYxTvGdzu+m6b3Q=ho=xL0kpWWqCn0vjj-gOe0ZQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xRLnZ-000000002fb-32EI
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip further SIT updates for already
 invalidated blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: jaegeuk@kernel.org, yi.sun@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgQ2hhbywKClRoYW5rcyBmb3IgY2hlY2tpbmcuCkkgYWdyZWUgdGhhdCA4MWZmYmQyMjRlNWYg
aXMgdGhlIHJpZ2h0IEZpeGVzIHRhZy4KCknigJl2ZSBzZW50IHYyIHdpdGggc3RhYmxlIG9uIENj
IGFuZCBhbiBhZGRpdGlvbmFsIEZpeGVzIHRhZyBmb3IKYTY2Y2RkOTg1NTMyIHRvIGNvdmVyIHRo
ZSBkaXNjYXJkIGJpdG1hcCBoYW5kbGluZy4gRG9lcyB0aGUgc2Vjb25kCkZpeGVzIHRhZyBsb29r
IGFwcHJvcHJpYXRlIHRvIHlvdT8KClRoYW5rcywKU2VvbmdqYWUKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
