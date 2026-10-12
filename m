Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36792CA9EDE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nakoFU5bmol3FjTtpeUapQHtog1ZNIUnSbWBXDLn4Zo=; b=cLiRIN55MFE8o9dXTrY3HSHdQY
	2+2klOsTFQZwcDCzD2lVFmMi7rSC2KFCxX9kWmeMfFzAkOSfpKiduehW9SkVlyQ7CGS9X3FMcsHBe
	bV3lPZSWlGPw/DJs6yX9taCnuhDyicUOiEP5MWFRLDcmhCDf3WgGT3nBw91GqK60eE6o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGL2k-00068c-50;
	Mon, 12 Oct 2026 18:46:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xGL2j-00068W-G8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 18:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VGXcf0ARVBkmMwtiaf/S8Kf8sFefK7Cy09KXxnSmvl0=; b=UUhqQgz/AGwox1p/iE3aJnSPss
 yqpmZZX4YDtYjRV868iJjZPmiVQDJk/mhJCrq+9+JRT4LCByK0HYw9tX1HUkvwmADkRquCklFjBeZ
 MteVDRV63cIOahPwjwMa0EJEo7veHglrfxBqEeQXfii8/EPIvRNRW6mHwhmQdWlnHfCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VGXcf0ARVBkmMwtiaf/S8Kf8sFefK7Cy09KXxnSmvl0=; b=GCDbJ/FbJRFpO4sIbXeyhWM09e
 3Z2TGt4rDgKcL8TX6XMlP2M2AIyCOkJSCzY/IzNvS+btV7vC4YFLrwnw7C6HPK2P97dEF07IMWtto
 iMVgUwLwgIDpvHmxM4/qrkWjO69YQ+FHcBu/7lnSm3r0P4odDXuEghP832iQ/TZZt3Tg=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGL2j-0002P9-10 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 18:46:37 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso8300725ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 11:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791830791; cv=none;
 d=google.com; s=arc-20260327;
 b=VcxlPGTGL8AuGakBw/7cWNQbyer3HXKBqdZ+WLyZRDXsD7C7K5Wyh6DeQ5JpjR2Wd0
 ttAN4Nw+cRREc89i0PkQjTfiy6YB0Usz35iTWcad72WFGGD7+UPJspBN6EEItoljqBII
 EppCss4zLU7/Ny8rmDglWYQm9MLpONc79pDm87aAjuktjcJOMTzB0CAt241NEa/OTK4S
 CAuUQsVOXnyXUUhfMoYAbtjL59Q28eweXGgmUMYei+bjpSU/PucjmthAkSmZB5Laac07
 FZhwELWc0LBHKfdQ2sETM4xdL6WPUSJZrgda9JBteqc4Vq11n/521qtTsB8JAt6jpRIV
 /kSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VGXcf0ARVBkmMwtiaf/S8Kf8sFefK7Cy09KXxnSmvl0=;
 fh=+d1maXHcxmwFk/kECipg/d/l8eYZxKbe7EG8R8lohto=;
 b=EqeS4bvdO327HfyvgO7GvV22Is8Y/accSMcZ0xgEJSh9qx+C2QkB8ZpAVOZNUGcOEi
 uoRZewy581eZqRstQhJFaTwoVgxkql25xeK042ED3i0sujb1X+zMrwQvxbZw2qEIaNZK
 tqHQGu/hq8KqI94QMZjL2Kwd62QmFVVfhTCJNibOwuLiJQkmo0JVXxlr3RH/oVJi3l8M
 1ewFgnAvI83xdd00gWXgbaK9MibiCBVlf+lnUeR5PR+b4nC7OWLUNu+kqwVf4JHty7jH
 OI/XMouxqQMhn5OLlCxv/v+8bAX/h6q+zPz+KSXAm/kL8xtCp/GjI+fip+qAUWDDWDZr
 r/jw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791830791; x=1792435591; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VGXcf0ARVBkmMwtiaf/S8Kf8sFefK7Cy09KXxnSmvl0=;
 b=pzkqYBRyLjMmOLdRZ/ODqELVRfTleKRDmQYJtRJKbpOXb5miHuxhRQRTwq1vVtxmqf
 DfWATTHNjTge91AQ5JG94xCnQRe1SyPgeXFEFDvoN3tRjidQMyW+gH8Sko0OzCJGT0Bo
 zeAhA92VXOKtaH22AzkjA1SBgubJKgORQJsNiVo9vPWbCY0sVzjvs+EyD0vjYKNP+Bt8
 tcqdHoEp7PUjYLuXFoyTQQPx1sQRDBNiW7iaMGn7S6b7I55mCVv0pKpLTxErtYdlzjdL
 CvzlRi9bjVzCEIZOww+NquqmB7jwBmI4Efj8YScS/LCHy40/99yYf1rskGwp9eba0rvc
 U6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791830791; x=1792435591;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VGXcf0ARVBkmMwtiaf/S8Kf8sFefK7Cy09KXxnSmvl0=;
 b=YWrq9XJ0fmalYjntdn+5K+Tku4u8gmP3MrRi4d3uOYNdhKWmZj6KcXYbNf0aII9bYW
 iluyK6q+MZcLxA2uRirpxmTAgDU5IsSvnDAeQOY0SeNTgJa81OfWmkaPD0A46qGalYyr
 KOmWIqoe5iwoa4P+gJ2/8Nm87MQLgv5KmjDUjMlGK7Or21WXKDb23A6lVL2kTQgzMcTp
 AX/27PYWIdzGOAwCF0dwIwY7hBfLf1nA6ftAbuPRc780U2XdabORCrgceaziiNbehbku
 leoK7AArlBUkdPRcdueHn0Vu0xEgvHvGAIVPB7F05JKUL+LEqyHUhPdkcPaPhdl+kZti
 49LQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLIn/EWPkL8SVQhW+EoF+yVIy9Pcal9Tdnx+QeqmlnfOfELgfESDKVxMI5NxuPuJXsiLkCO4689hxHP/1BkteX@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKOf1+sTvYOHh6cIa/Z/LSRN2vFGKf/exsGbM4yKwOkUIcqMXG7
 uUjlmgkOUCgIHR5KcYsjeQwMikJw1PZkOHXgWTiLEAJp3gYp/f4uaY3hUL/DenRb7mRfD6+PmFv
 SkSRlL8k+/SzCCWEVGA2BtJcNDvxluaSDKA==
X-Gm-Gg: AYBFou3767fU6ApEXBjr/HU4sNN3opANsHypuFJ0Zg84lFe6nbmVYTWqZlL/oDQKRjk
 5scuchbOOakwLxgq0JRkvY8kxbIY9v9ds86naZnWAQzAv+4QvbCdV0n5x6RQy9rq5P7B+VoGwJ1
 3y1BwpITumu87/YeX5ThMxV0c1rH9juMNCWMyruToBOq5n13/ow0/x0SLo5fk9Wnm4gZ1BmNBut
 lJL3D7t7yLz/sl4iesr+Evk204Et+POuvpmiJXD/r2prAH8mAbDIgLfJ9I6c/2+LryQwCxkHnEG
 QrxwiHijrDxhbIBavmCcLp0oZUg4eLFtxYQwcRF1JR3guuLeZf3Sl7KfuKElPerhJc6R25AEddi
 3G+91Tz83kbzvzb9gfZO5mb0SfjevN34DlhSSqWqIyTg=
X-Received: by 2002:a17:903:38c8:b0:2d8:d4cd:dc8f with SMTP id
 d9443c01a7336-2e842ab8115mr85849255ad.18.1791830791163; Mon, 12 Oct 2026
 11:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261001180758.2099491-1-daeho43@gmail.com>
In-Reply-To: <20261001180758.2099491-1-daeho43@gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 12 Oct 2026 11:46:15 -0700
X-Gm-Features: AclHuK_AXzsOGRQGRcR2-gxwOApKYz3H5Nd1BDK7klATbk90vU191GFnNtuBy8o
Message-ID: <CACOAw_z6eVFMg8qGzCXkbGk_Jxa6Wv1JBjaq2Tf12qE9LbJgmA@mail.gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 kernel-team@android.com
X-Headers-End: 1xGL2j-0002P9-10
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: enable fix_on when
 CP_RESIZEFS_FLAG is set in auto-fix mode
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVGh1LCBPY3QgMSwgMjAyNiBhdCAxMTowOOKAr0FNIERhZWhvIEplb25nIDxkYWVobzQzQGdt
YWlsLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUu
Y29tPgo+Cj4gQ29tbWl0IDlhMzFjZWZhMjk2NiAoImZzY2suZjJmczogYWxsb3cgZnNjayB0byBm
aXggaXNzdWVzIHdpdGggb25saW5lCj4gcmVzaXplIGR1ZSB0byBTUE8iKSBhZGRlZCBsb2dpYyBp
biBzYW5pdHlfY2hlY2tfY2twdCgpIHRvIHJlY2FsY3VsYXRlCj4gYW5kIGZpeCB1c2VyX2Jsb2Nr
X2NvdW50IHdoZW4gQ1BfUkVTSVpFRlNfRkxBRyBpcyBzZXQgYWZ0ZXIgYSBzdWRkZW4KPiBwb3dl
ci1vZmYgZHVyaW5nIG9ubGluZSByZXNpemUuCj4KPiBIb3dldmVyLCBzYW5pdHlfY2hlY2tfY2tw
dCgpIGNhbGxzIGYyZnNfc2hvdWxkX3Byb2NlZWQoKSBhbmQgY2hlY2tzCj4gYy5maXhfb24gYmVm
b3JlIHJlcGFpcmluZyB1c2VyX2Jsb2NrX2NvdW50LCB3aGlsZSBmMmZzX3Nob3VsZF9wcm9jZWVk
KCkKPiBkaWQgbm90IGNoZWNrIENQX1JFU0laRUZTX0ZMQUcgd2hlbiBzZXR0aW5nIGMuZml4X29u
IGluIGF1dG9fZml4ICgtYSkgb3IKPiBwcmVlbiAoLXApIG1vZGUuIEFzIGEgcmVzdWx0LCBydW5u
aW5nICdmc2NrLmYyZnMgLWEnIGFmdGVyIGFuIFNQTyBkdXJpbmcKPiBvbmxpbmUgc2hyaW5rIGxl
YXZlcyBjLmZpeF9vbiB1bnNldCBhbmQgZmFpbHMgdG8gcmVwYWlyIHRoZSBjaGVja3BvaW50Lgo+
Cj4gQ2hlY2sgQ1BfUkVTSVpFRlNfRkxBRyBpbiBmMmZzX3Nob3VsZF9wcm9jZWVkKCkgc28gdGhh
dCBhdXRvLWZpeCBhbmQKPiBwcmVlbiBtb2RlcyBwcm9wZXJseSBlbmFibGUgYy5maXhfb24gYW5k
IHJlY292ZXIgdGhlIGZpbGVzeXN0ZW0uCj4KPiBGaXhlczogOWEzMWNlZmEyOTY2ICgiZnNjay5m
MmZzOiBhbGxvdyBmc2NrIHRvIGZpeCBpc3N1ZXMgd2l0aCBvbmxpbmUgcmVzaXplIGR1ZSB0byBT
UE8iKQo+IFNpZ25lZC1vZmYtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+
Cj4gLS0tCj4gIGZzY2svbW91bnQuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKPgo+IGRpZmYgLS1naXQgYS9mc2NrL21vdW50LmMgYi9mc2NrL21vdW50LmMKPiBpbmRl
eCAyZmQ4ZTFjLi44NDc5ZWQxIDEwMDY0NAo+IC0tLSBhL2ZzY2svbW91bnQuYwo+ICsrKyBiL2Zz
Y2svbW91bnQuYwo+IEBAIC0xNTE1LDYgKzE1MTUsNyBAQCBzdGF0aWMgaW50IGYyZnNfc2hvdWxk
X3Byb2NlZWQoc3RydWN0IGYyZnNfc3VwZXJfYmxvY2sgKnNiLCB1MzIgZmxhZykKPiAgICAgICAg
IGlmICghYy5maXhfb24gJiYgKGMuYXV0b19maXggfHwgYy5wcmVlbl9tb2RlKSkgewo+ICAgICAg
ICAgICAgICAgICBpZiAoZmxhZyAmIENQX0ZTQ0tfRkxBRyB8fAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGZsYWcgJiBDUF9ESVNBQkxFRF9GTEFHIHx8Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZmxhZyAmIENQX1JFU0laRUZTX0ZMQUcgfHwKPiAgICAgICAgICAgICAgICAgICAgICAgICBm
bGFnICYgQ1BfUVVPVEFfTkVFRF9GU0NLX0ZMQUcgfHwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBjLmludmFsaWRfc2IgJiBTQl9ORUVEX0ZJWCB8fAo+ICAgICAgICAgICAgICAgICAgICAgICAg
IChleGlzdF9xZl9pbm8oc2IpICYmIChmbGFnICYgQ1BfRVJST1JfRkxBRykpKSB7Cj4gLS0KCktp
bmRseSBwaW5nIHRoaXMuCgpUaGFua3MsCgo+IDIuNTYuMC5yYzEuMzE1LmdjNmVkOTkzNGI3LWdv
b2cKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwK
