Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FC7CA9EC7
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 01:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xozGKckahL1xTyQI2F6BLioa7WCpLXh07iw3kVm57Vg=; b=MewMtDF2lDm6VLBAvMJML0iYNj
	LXVNpE1EBB1G1OYLYwDY/e0GY5k5zce7+A8y+ZEhWqnANOzIm6VjKVb5YmiMptO8nSAbgDi6aCNXo
	1ppzBQgtFuH/8F9yC1SI9WLZFDWkOBxwqiF5R6mDVN+HGZKev5YNG47GhKsvcpTXaavk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFi7W-00006E-Ul;
	Sun, 11 Oct 2026 01:12:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFi7V-000067-3G
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 01:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NvrsV/yRTxF7AYvg3yJzAkG4U4DdRxEbM6TZbJGi+Lk=; b=Z9cXIgtcMA0gO9XlW6eubSGev5
 5BpWBdP3RQN4I7nIUzkXvV9o+cPbUMRNbYMzrJqRuRfqj2VrXdMXNlIxVsUIJkX7r+tf8MfblbTh7
 lAA9PgYkW0qiCb6e6wUru14aPrMuape2op9AsazdZXKAprgzyr49TXZKM7khEBH8Yzqg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NvrsV/yRTxF7AYvg3yJzAkG4U4DdRxEbM6TZbJGi+Lk=; b=bSJw+pbptH+hjjzEEzYD6lo06d
 Hm/A4jG/pu/2H1liRJO9n/K4LASuMoFtwvKoH4bBhjyAt3u/H7rJz//RWeh+JhfCc3ze02ppFt/YU
 zfpxh0j8rIuxX1Dum0+subr2lWQ8L9skKbkrbbG8mrpvecQ1ylD65OGNrfNJNaQRW4aA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFi7V-0005qM-A2 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 01:12:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B7B1A60018;
 Sun, 11 Oct 2026 01:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6411F000FF;
 Sun, 11 Oct 2026 01:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791681171;
 bh=NvrsV/yRTxF7AYvg3yJzAkG4U4DdRxEbM6TZbJGi+Lk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=nm63OXxEsw8iNhkNgzJq++UqEoM81d/ehBLU5IjkK300BGpxVbCHnhkAZybalto2U
 93xLFApgYDT0z8PZ2BSE8WErCSRJtuJSy0nKigtOcI3KeB+4LnjtQexUa0YU565Ngq
 EPTvB1S/1vAqPwtHMe7qaQy2DACVj66C77AOdt8FMKiGhRqQUCuhKimRFWFqE/CvSx
 KqS9aucWZWNSVsnN6quelp2+ooehw7UewV+duDJLYZW7hSj8xd/hsYssTfA8gLi+Fn
 OgCvjTH8UAB3CypwQndjZHOwjYqwwqvUheCSA2XJA8fuacsbGjBgU8qCQoXe6hCgAv
 XFOaz0M/OmNNg==
Message-ID: <9b27eadf-f962-41d8-95ba-11a507fcc58f@kernel.org>
Date: Sun, 11 Oct 2026 09:12:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Juhyung Park <qkrwngud825@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20261005201605.693574-1-qkrwngud825@gmail.com>
Content-Language: en-US
In-Reply-To: <20261005201605.693574-1-qkrwngud825@gmail.com>
X-Headers-End: 1xFi7V-0005qM-A2
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs-tools: fix discarded const
 qualifiers
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMTAvNi8yNiAwNDoxNiwgSnVoeXVuZyBQYXJrIHdyb3RlOgo+IGNvbXByZXNzLmM6IEluIGZ1
bmN0aW9uIOKAmGdldF9leHTigJk6Cj4gY29tcHJlc3MuYzoxMzY6MTk6IHdhcm5pbmc6IGluaXRp
YWxpemF0aW9uIGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFy
Z2V0IHR5cGUgWy1XZGlzY2FyZGVkLXF1YWxpZmllcnNdCj4gICAgMTM2IHwgICAgICAgICBjaGFy
ICpwID0gc3RycmNocihwYXRoLCAnLicpOwo+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgIF5+
fn5+fn4KPiBmMmZzY3J5cHQuYzogSW4gZnVuY3Rpb24g4oCYaGV4MmJ5dGXigJk6Cj4gZjJmc2Ny
eXB0LmM6MjEwOjE5OiB3YXJuaW5nOiBhc3NpZ25tZW50IGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1
YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZGlzY2FyZGVkLXF1YWxpZmllcnNd
Cj4gICAgMjEwIHwgICAgICAgICAgICAgICAgIGggPSBtZW1jaHIoaGV4Y2hhcnMsIGhleFt4XSwg
aGV4Y2hhcnNfc2l6ZSk7Cj4gICAgICAgIHwgICAgICAgICAgICAgICAgICAgXgo+IGYyZnNjcnlw
dC5jOjIxMzoxOTogd2FybmluZzogYXNzaWdubWVudCBkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFs
aWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQo+
ICAgIDIxMyB8ICAgICAgICAgICAgICAgICBsID0gbWVtY2hyKGhleGNoYXJzLCBoZXhbeCArIDFd
LCBoZXhjaGFyc19zaXplKTsKPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICBeCj4gZjJmc2Ny
eXB0LmM6IEluIGZ1bmN0aW9uIOKAmHBhcnNlX3NhbHTigJk6Cj4gZjJmc2NyeXB0LmM6MzcxOjI3
OiB3YXJuaW5nOiBhc3NpZ25tZW50IGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBmcm9t
IHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZGlzY2FyZGVkLXF1YWxpZmllcnNdCj4gICAgMzcxIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgaCA9IG1lbWNocihoZXhjaGFycywgKmNwKyssIGhleGNo
YXJzX3NpemUpOwo+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+IGYyZnNj
cnlwdC5jOjM3MjoyNzogd2FybmluZzogYXNzaWdubWVudCBkaXNjYXJkcyDigJhjb25zdOKAmSBx
dWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJz
XQo+ICAgIDM3MiB8ICAgICAgICAgICAgICAgICAgICAgICAgIGwgPSBtZW1jaHIoaGV4Y2hhcnMs
ICpjcCsrLCBoZXhjaGFyc19zaXplKTsKPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKdWh5dW5nIFBhcmsgPHFrcnduZ3VkODI1QGdtYWls
LmNvbT4KClJldmlld2VkLWJ5OiBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+CgpUaGFua3MsCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJm
cy1kZXZlbAo=
