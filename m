Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF2AE95A8F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Oct 2023 02:05:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qpfeT-0005nN-FP;
	Mon, 09 Oct 2023 02:05:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <37F8jZQkbAGkZfgRHSSLYHWWPK.NVVNSLbZLYJVUaLUa.JVT@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1qpfeS-0005nH-3l for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Oct 2023 02:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:To:From:
 Subject:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cb8BJFOfJt/1KSmkcKeu7s/bXsY2CA0V26Ucc8VKgjw=; b=A/IN4q2ia3Cf6OXLwXsZWmzoFV
 3twv6QTYI3zdsbe1orT19JqeKJlGmVSgXFZR4dPqdgHv6KsfCDBz1UGNBBCQ1D0GnUM10XPS4Y4Eh
 UQMxTwIs6vhE5JhZAlGIt7EEEHZahxh7AnGsfib6CkXYuGAA8HiU2Nr3rDMAbCQfUeBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:To:From:Subject:Message-ID:
 In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cb8BJFOfJt/1KSmkcKeu7s/bXsY2CA0V26Ucc8VKgjw=; b=d4oAdUC72S7hlFRkE6rV5RVAnk
 +EmQtSCqyNApRUqsd6zv+Wn1qk/97JQ/LGJzrblvitKB9Ddk0WisFyfUiWa0QVKMwiL7899Hk7TGQ
 ie9aQsGtO0DVHmx6olFeRCnjtZBS/2uz32djpK518G9G8/KohetfpjcQZquIX5iftnVM=;
Received: from mail-oa1-f72.google.com ([209.85.160.72])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qpfeM-00034b-2G for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Oct 2023 02:05:41 +0000
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1e5a011f708so3655316fac.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 08 Oct 2023 19:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696817132; x=1697421932;
 h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
 :date:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cb8BJFOfJt/1KSmkcKeu7s/bXsY2CA0V26Ucc8VKgjw=;
 b=nmKkL1pUWuW+htTO4KyCKALO6BAsZipRoAoRRxgiPk2+smlUR+In4SenwGdTKj6i5q
 4XRdp/QXfqfd28BdYQ8YBznTjuPbrDPMwlAOZgx15xIYG030SJmjcRGSyfWPp2twQc75
 D4xKXBqqADc5nKK1UW4C095c9xqVTOcWS7nQ2ajzN2lQSQh87vHgMQ85oQJTF+ASyGRg
 D5p6MDcpsaA8U+31Fw3Npknr4XpNdITAjR92ifD5a6RLjaNVMsdQXjRk0No75QLJx11q
 AhRewwJ6agsyUTg9uQKnC5igiZLICe9VnRK3z1oF9dpB1WuPkVokd4IRPwe5CHT7hNLt
 b9wA==
X-Gm-Message-State: AOJu0Yy3clfM9aiv+oPBNWBFxfkB++9AQFy50Dw/ISR8CrTB5OtPhhjB
 cFY9KMdGyePwwntQV/93tCTI3yX7EaIbEPyDyaK09x1qWUIh
X-Google-Smtp-Source: AGHT+IELFqFN7QoMVYfsIY7r0QeAGPzrcev1WXJ9FLIcjCL1sovTwvIQxukZvcnCCdk9WKGEwgiUlAPYacJT+fS5YBjM7tUk1k16
MIME-Version: 1.0
X-Received: by 2002:a05:6871:3208:b0:1d5:a24a:c33 with SMTP id
 mo8-20020a056871320800b001d5a24a0c33mr5413341oac.8.1696817132668; Sun, 08 Oct
 2023 19:05:32 -0700 (PDT)
Date: Sun, 08 Oct 2023 19:05:32 -0700
In-Reply-To: <0000000000001825ce06047bf2a6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071133306073f06ca@google.com>
From: syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chao@kernel.org, 
 daniel.vetter@ffwll.ch, hdanton@sina.com, jack@suse.cz, jaegeuk@kernel.org, 
 jinpu.wang@ionos.com, linux-f2fs-devel@lists.sourceforge.net, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mairacanal@riseup.net, mcanal@igalia.com, reiserfs-devel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, terrelln@fb.com, willy@infradead.org, 
 yukuai3@huawei.com
X-Headers-End: 1qpfeM-00034b-2G
Subject: Re: [f2fs-dev] [syzbot] [reiserfs?] possible deadlock in super_lock
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

c3l6Ym90IGhhcyBiaXNlY3RlZCB0aGlzIGlzc3VlIHRvOgoKY29tbWl0IDc5MDg2MzJmMjkyN2I2
NWY3NDg2YWU2YjY3YzI0MDcxNjY2YmE0M2YKQXV0aG9yOiBNYcOtcmEgQ2FuYWwgPG1jYW5hbEBp
Z2FsaWEuY29tPgpEYXRlOiAgIFRodSBTZXAgMTQgMTA6MTk6MDIgMjAyMyArMDAwMAoKICAgIFJl
dmVydCAiZHJtL3ZrbXM6IEZpeCByYWNlLWNvbmRpdGlvbiBiZXR3ZWVuIHRoZSBocnRpbWVyIGFu
ZCB0aGUgYXRvbWljIGNvbW1pdCIKCmJpc2VjdGlvbiBsb2c6ICBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS94L2Jpc2VjdC50eHQ/eD0xN2ZjMDU2NTY4MDAwMApzdGFydCBjb21taXQ6ICAg
MmNmMGY3MTU2MjM4IE1lcmdlIHRhZyAnbmZzLWZvci02LjYtMicgb2YgZ2l0Oi8vZ2l0LmxpbnV4
LS4uCmdpdCB0cmVlOiAgICAgICB1cHN0cmVhbQpmaW5hbCBvb3BzOiAgICAgaHR0cHM6Ly9zeXpr
YWxsZXIuYXBwc3BvdC5jb20veC9yZXBvcnQudHh0P3g9MTQwMjA1NjU2ODAwMDAKY29uc29sZSBv
dXRwdXQ6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTEwMDIwNTY1
NjgwMDAwCmtlcm5lbCBjb25maWc6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5j
b25maWc/eD03MTBkYzQ5YmVjZTQ5NGRmCmRhc2hib2FyZCBsaW5rOiBodHRwczovL3N5emthbGxl
ci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9MDYyMzE3ZWExZDBhNmQ1ZTI5ZTcKc3l6IHJlcHJvOiAg
ICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uc3l6P3g9MTA3ZTk1MTg2
ODAwMDAKClJlcG9ydGVkLWJ5OiBzeXpib3QrMDYyMzE3ZWExZDBhNmQ1ZTI5ZTdAc3l6a2FsbGVy
LmFwcHNwb3RtYWlsLmNvbQpGaXhlczogNzkwODYzMmYyOTI3ICgiUmV2ZXJ0ICJkcm0vdmttczog
Rml4IHJhY2UtY29uZGl0aW9uIGJldHdlZW4gdGhlIGhydGltZXIgYW5kIHRoZSBhdG9taWMgY29t
bWl0IiIpCgpGb3IgaW5mb3JtYXRpb24gYWJvdXQgYmlzZWN0aW9uIHByb2Nlc3Mgc2VlOiBodHRw
czovL2dvby5nbC90cHNtRUojYmlzZWN0aW9uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
