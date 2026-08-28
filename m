Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48FAC61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vSyhFwMcWliVxCT+ITewfxNn+cfe8dQlgiep1LNoRY=; b=P18iIxIdCdBA9Y1VTp3XwURMQA
	Ltsu8XXUtLFlSPRKHh5iuwJ4jiwnV4zDVw9GY+A3MGHjkY4GI7ihPHrIIJFWabBLv7uvfLAJ/7v/1
	dvE8xvpwWGDJuTlrQLJ3E15x06BpJcECRuFk65HPI5GvfeamZO/MLJRYoSKRrGeL5dWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzvGR-0008UT-K5;
	Fri, 28 Aug 2026 12:00:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzvGQ-0008UN-Ht
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nhyFDn9PEo2P8Bzd+kfnCU3zIUb6BEo+lMrrxRURVTc=; b=YLuygKlrFvTuxVFtZVTgLEx/nV
 O88wc3WnGHoPEmHe2c3R+abkSo2Ezq+1WU+n92rik6WCHhQJlERhh5JrCH3BEWTLgrsql63cF384f
 /0nbNqnCmF+iHf0y6tkN/WkZeyI9v3rOl4oNWeOLTR3uGooM6v6JXbkasS6rhDPvsYzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nhyFDn9PEo2P8Bzd+kfnCU3zIUb6BEo+lMrrxRURVTc=; b=Og8NEEVBtPI2muz+pFDC8ggrOq
 KFLkfCx3lE8IfSnKHaRXeggbSZsYNxy7b4y++r9GLd1CWX5TWm5QLhIJGWnkhEMNVJAO4bCFA1W5V
 VaXe4J159uX1SDgewYuedzgoThw3OwsQ5AerQd5SGkTaskgzb+xapZoLm3ieBLZTFEdU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzvGO-0003zz-FF for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:00:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA388601F5;
 Fri, 28 Aug 2026 12:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A300F1F00A3A;
 Fri, 28 Aug 2026 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787918446;
 bh=nhyFDn9PEo2P8Bzd+kfnCU3zIUb6BEo+lMrrxRURVTc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=kp23YizF8QHDuhcMi/DAsg98Dj964i8o36nUbIzzQ1/3B0J3dpthoNKnH55VoAKlt
 QeW6sI3j73T05prrLjrp2ocLu60DL2d78k/3dRdiiHtyPzvEsiRcvC1FKKXzZ3pSks
 Yd8I+ZW+guXujNU5Jxa2QB3TXOvoDa9o3+TYo3zl+ImLuovz6MZwwkTW5s8sGgK7n2
 Pam6xXOYicQDXE0X4YghixDTj8odlnKwUCX2TIcEpXeWRACCZCjPTRPoWFKCZS8aKj
 bMuRLz0/E1PMuy+hewZx14IKbj7oovKI0lmfHO6MNktHIGETI2AfG9SXeue5/zwsXA
 T8hEVumHOgLDw==
Message-ID: <b4711014-844e-45c0-b85a-4e3a98d7137c@kernel.org>
Date: Fri, 28 Aug 2026 20:00:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260825130126.2078627-1-chao@kernel.org>
 <20260825130126.2078627-10-chao@kernel.org>
 <CACOAw_w+QMkTNK=McScLHh1gpm6UFjxLSnVxhFMsgsuArLA=qQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_w+QMkTNK=McScLHh1gpm6UFjxLSnVxhFMsgsuArLA=qQ@mail.gmail.com>
X-Headers-End: 1wzvGO-0003zz-FF
Subject: Re: [f2fs-dev] [PATCH v3 09/12] f2fs: cache: use compress cache
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8yNy8yNiAwNDowNCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gT24gVHVlLCBBdWcgMjUsIDIw
MjYgYXQgNjowM+KAr0FNIENoYW8gWXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwKPj4gKyAgICAgICAg
ICAgICAgIGYyZnNfbG9ja19jYWNoZShlbnRyeSk7Cj4+Cj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGlmIChpbm8gIT0gZm9saW9fZ2V0X2YyZnNfZGF0YShmb2xpbykpIHsKPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBmb2xpb191bmxvY2soZm9saW8pOwo+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+PiAtICAgICAgICAgICAgICAgICAgICAg
ICB9Cj4+IC0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgZ2VuZXJpY19lcnJvcl9yZW1vdmVf
Zm9saW8obWFwcGluZywgZm9saW8pOwo+PiAtICAgICAgICAgICAgICAgICAgICAgICBmb2xpb191
bmxvY2soZm9saW8pOwo+PiArICAgICAgICAgICAgICAgaWYgKCFmMmZzX2lzX2NvbXByZXNzX2Nh
Y2hlKGVudHJ5KSkgewo+IAo+IEhvdyBpcyB0aGlzIHBvc3NpYmxlPwo+IG9yIGlmICghZW50cnkt
PmNhY2hlKT8KCkkgc3VmZmVyIGEgcGFuaWMgZnJvbSBmMmZzX2J1Z19vbihzYmksICFmMmZzX2lz
X2NvbXByZXNzX2NhY2hlKGVudHJ5KSkgaGVyZSwKaXQgbWF5IHN1ZmZlciByYWNlIGNvbmRpdGlv
biB3LyBzaHJpbmtlci4KClRoYW5rcywKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZz
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
