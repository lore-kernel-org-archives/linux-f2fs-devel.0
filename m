Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED3FD1D88B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Oct 2024 17:01:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t0kvc-0003uZ-P9;
	Tue, 15 Oct 2024 17:01:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1t0kva-0003uS-Tb
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Oct 2024 17:01:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=63FYT/PuxOMQbAuecv0AdF59L7+9iuwWpjhJoZyAZOo=; b=LnblPY46f3hRnAmDwAotLwsu+m
 mxfCTkQlQPNmca+3iSTkHzTRa2Ij1z27cGMjAedmLzb3eGEwFBVSJgjenCzSwoVptVtAoyUCik6pY
 S8VUSgx8RJkrZYxb0SDskW5FrIliSdlkiN/h0Ix3Ps7SRSdr40Xvw9GUjhw7knKjSU4k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=63FYT/PuxOMQbAuecv0AdF59L7+9iuwWpjhJoZyAZOo=; b=NnALjHauqiyfKSVLFHdZ64s0bf
 Y3kv7ij5KvAJpa6fJ4QtITf+R/g8VRJcHjy/6Y3GSEImJ+/yrd4KpptRvgt3hueqoFz4V0gyINAha
 OkXnt7C1cr03NxDq5aiQxQYtvVwEBfLZSxihn5f7mDLP1qHKky1A26sGm25IGFMsq7xM=;
Received: from mail-vk1-f172.google.com ([209.85.221.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1t0kvb-0003g5-0h for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Oct 2024 17:01:47 +0000
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-50c9f4efd09so1619358e0c.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Oct 2024 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729011701; x=1729616501; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63FYT/PuxOMQbAuecv0AdF59L7+9iuwWpjhJoZyAZOo=;
 b=i5Zn2fr/WAVBRuPH6W+u/vbXWQh6BlDuA4GlPdV9QgOu+fudaXX5rXjHdb0kmfH6XF
 XnDMYTJzhcVfQlvEmOcCzu0asQcl3tWXHjl3yJ8XQs9C0iCizrb/GQDS/86VoPVnz5Iq
 a2gwigkMZnSy197bw57/vAaod3DyHpuF8tT5MnkOQMvipSKU8RCK9lhDK0MSIe86TCqF
 ivgQEoeH1vUIptEGZ/3yXLKm0Xb5DR1okMVKVTs8uJHJlOL5qeDXInvJbiaBEe1VjFJN
 mH92w3DLWwdg1TpbokMDhZk8w/532VPFkfOa7nvLLaoiFQIowXexz/hGU4ygXwJVs5Fw
 LurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729011701; x=1729616501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63FYT/PuxOMQbAuecv0AdF59L7+9iuwWpjhJoZyAZOo=;
 b=eKN5LtTR8Z5Tio4QWsnsweb5rF8QqrOd0XIp0LkbFK0JGQVGvpffs3lZChP8keRaIw
 5VJOZTm0wPN+X0oD9Xqx3MKdmew5TLs7OasVF7PdLVnTzHw/YkYaBkk4k7JiRUnjLt3Z
 IrXhTouWdvHqSTrWfkeCUfwjcQDCeyDawPBD2UDzwnYAmf8EZ6waAgdrAWLtkYzlbQQl
 8+7qLexKM+xjt/VZvaCgRwmVVFB/WH39hbg6ok98EJ21fBW0o717BU2LT1O7wc6vjmIH
 nV2VpmWuCliW6pNg8LjgA4x5OptUUQM6VYmegS7QukckQhGppQbAqT57v/dJ1ZoeTmzs
 0v8Q==
X-Gm-Message-State: AOJu0Yw7ILGDA3wB9f9l1ZieV6SeoRQCAYw7hLU0mLcjWZycRky5CuRQ
 RJpA3Cjmhv0v44eTCPO7Bfdxa/GvicQbp4QuhNijLslbJMGv86x9BNrZk0OXwxYAwLZ8IAPapa+
 6yiDqwlcW5a2NKi3Kwob7UH7Wr6Jze4t9
X-Google-Smtp-Source: AGHT+IGVNIekyXBWjUNJy6YMMxkhRdfj8T55fIRneqb9ZYNd01G/8wcFC2qbSht3grC9LgELwO4GXUqBQdifzInoLEg=
X-Received: by 2002:a05:6122:2189:b0:509:e5b5:d133 with SMTP id
 71dfb90a1353d-50d376b651emr6974952e0c.6.1729011700825; Tue, 15 Oct 2024
 10:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241015165616.65434-1-jaegeuk@kernel.org>
In-Reply-To: <20241015165616.65434-1-jaegeuk@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 15 Oct 2024 10:01:28 -0700
Message-ID: <CACOAw_zth8iM3JMmdPu29UxKzZ5vVW=oVjy=3R=oVc1cVQ5N_g@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1t0kvb-0003g5-0h
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: don't trim on aliased partition
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

UmV2aWV3ZWQtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+CgpUaGFua3Ms
CgpPbiBUdWUsIE9jdCAxNSwgMjAyNCBhdCA5OjU44oCvQU0gSmFlZ2V1ayBLaW0gdmlhIExpbnV4
LWYyZnMtZGV2ZWwKPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0PiB3cm90
ZToKPgo+IFNpZ25lZC1vZmYtYnk6IEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Cj4g
LS0tCj4gIG1rZnMvZjJmc19mb3JtYXRfdXRpbHMuYyB8IDUgKysrKysKPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL21rZnMvZjJmc19mb3JtYXRfdXRp
bHMuYyBiL21rZnMvZjJmc19mb3JtYXRfdXRpbHMuYwo+IGluZGV4IDFjMjAwM2U4ZDEwNy4uMWE5
NzQ2YTc3MTg0IDEwMDY0NAo+IC0tLSBhL21rZnMvZjJmc19mb3JtYXRfdXRpbHMuYwo+ICsrKyBi
L21rZnMvZjJmc19mb3JtYXRfdXRpbHMuYwo+IEBAIC00OCw2ICs0OCwxMSBAQCBzdGF0aWMgaW50
IHRyaW1fZGV2aWNlKGludCBpKQo+ICAgICAgICAgdWludDY0X3QgYnl0ZXMgPSBkZXYtPnRvdGFs
X3NlY3RvcnMgKiBkZXYtPnNlY3Rvcl9zaXplOwo+ICAgICAgICAgaW50IGZkID0gZGV2LT5mZDsK
Pgo+ICsgICAgICAgaWYgKGRldi0+YWxpYXNfZmlsZW5hbWUpIHsKPiArICAgICAgICAgICAgICAg
TVNHKDAsICJJbmZvOiBbJXNdIFNraXAgRGlzY2FyZGluZyBhcyBhbGlhc2VkXG4iLCBkZXYtPnBh
dGgpOwo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPiArICAgICAgIH0KPiArCj4gICAgICAg
ICBzdGF0X2J1ZiA9IG1hbGxvYyhzaXplb2Yoc3RydWN0IHN0YXQpKTsKPiAgICAgICAgIGlmIChz
dGF0X2J1ZiA9PSBOVUxMKSB7Cj4gICAgICAgICAgICAgICAgIE1TRygxLCAiXHRFcnJvcjogTWFs
bG9jIEZhaWxlZCBmb3IgdHJpbV9zdGF0X2J1ZiEhIVxuIik7Cj4gLS0KPiAyLjQ3LjAucmMxLjI4
OC5nMDYyOThkMTUyNS1nb29nCj4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
