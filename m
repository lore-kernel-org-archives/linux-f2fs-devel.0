Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51815C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Jul 2026 01:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wjxjh8FCTlJyg1HpxFybD1x/0jMWI/ZD8yO3TPStMGE=; b=h7xJSMOCo0SkUJp0/bVyRF1GOI
	AZna6Aonws5ffN91DCEzkNPDu41E8F4XCTzQbnhjRKDCH+oxtv8ePZejWuYCO1l/GP3kYXkbpNw5e
	eC7jKVHBRuaKQvJxJIybyNOGNduFLNq1dLKa6awnhBA7E2x0Tk8KCl35UrRaRIHVQFAE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wfSvu-00048L-EI;
	Fri, 03 Jul 2026 01:43:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wfSvt-00048F-Kz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 01:43:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AX4qRITMVBxo2syOiuIn5nihRYToP/HhChwFyF/gFaQ=; b=Z/OYfVxFRHSGvA6NMgWFcr/Uqr
 0AIy425rWSRJdZsb8+/mu24L+//BhB16nhpxGk/yxg81pYXHFG4HTUCjPKIUiaVQuwnY2afsTvw/0
 +AH6JLAFPOMACBm+z6Z2KVyjqwJXL8ras+Adxh+doGYiYGTTjSUbSeiyC7eLkmAa+OsE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AX4qRITMVBxo2syOiuIn5nihRYToP/HhChwFyF/gFaQ=; b=HuH5TWmymXEmeoTGtu2YP9b9Zw
 hd+hC7i6LWEbLKinMaDv3VD/5WRszeVS1raioIqJHHamhrlfZi8VaVs66ze2ebjrcUKiLsvFu8ZxP
 uz8g6xjSCrUCflTT87fuNKc2/pG+BbtjkXlqBpL9CoeJdKm8hfKya97KQ2mrdGm0gdDs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfSvq-00088v-3s for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 01:43:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 31877417C3;
 Fri,  3 Jul 2026 01:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EFEF41F00A3A;
 Fri,  3 Jul 2026 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783042976;
 bh=AX4qRITMVBxo2syOiuIn5nihRYToP/HhChwFyF/gFaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dJtuR/82aT9h1ImO0a7pYJQJ+soh57RpaSsmH5o5j8IK42iv/kQcFlPB7G3vFH4zD
 1cI/SGmmNm3EEL6hcAAYkT4Cd9gRd1KbwZAx1RrmLI0EXdSf/I7vlhkKUPloFFQFee
 mo7Sy4AoM5ffBWElmdGzSCFl7tzmoFL2T8PkfPcgWfWsmksc77beqcX/v8FPel49/a
 WL/a6F6omLU837kQyj/YQ2Bnb8p5c5Jge2S29NN/YRr4I65yaPrg3fle9EEwK5trBb
 rNXtXGBsg5Zx8ICE/FevfeOhXvdgaCFoi43mChEiMQwqoq9IOuC8mhW4d404Wyok50
 oL2V6nXFK4a4g==
Date: Thu, 2 Jul 2026 18:42:55 -0700
To: Joanne Koong <joannelkoong@gmail.com>
Message-ID: <20260703014255.GR9392@frogsfrogsfrogs>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-18-joannelkoong@gmail.com>
 <20260702165841.GM9392@frogsfrogsfrogs>
 <CAJnrk1YW0gKRVvHRC+WeKoV2vrquzaC6UkipZkQ34Z0RAQDjtg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJnrk1YW0gKRVvHRC+WeKoV2vrquzaC6UkipZkQ34Z0RAQDjtg@mail.gmail.com>
X-Headers-End: 1wfSvq-00088v-3s
Subject: Re: [f2fs-dev] [PATCH v2 17/18] iomap: pass iomap_next_fn directly
 instead of struct iomap_ops
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Ritesh Harjani \(IBM\)" <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Chunhai Guo <guochunhai@vivo.com>, Dan Williams <djbw@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Yue Hu <zbestahu@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Zhang Yi <yi.zhang@huawei.com>,
 willy@infradead.org, hch@lst.de, hsiangkao@linux.alibaba.com,
 Gao Xiang <xiang@kernel.org>,
 "open list:EXT2 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Andreas Gruenbacher <agruenba@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 "open list:FUSE FILESYSTEM \[CORE\]" <fuse-devel@lists.linux.dev>,
 brauner@kernel.org, Johannes Thumshirn <jth@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:NTFS3 FILESYSTEM" <ntfs3@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, "open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>,
 "open list:FILESYSTEM DIRECT ACCESS \(DAX\)" <nvdimm@lists.linux.dev>,
 Hongbo Li <lihongbo22@huawei.com>, linux-fsdevel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>,
 "open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVGh1LCBKdWwgMDIsIDIwMjYgYXQgMDU6MTc6MDJQTSAtMDcwMCwgSm9hbm5lIEtvb25nIHdy
b3RlOgo+IE9uIFRodSwgSnVsIDIsIDIwMjYgYXQgOTo1OOKAr0FNIERhcnJpY2sgSi4gV29uZyA8
ZGp3b25nQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL2lvbWFw
L2J1ZmZlcmVkLWlvLmMgYi9mcy9pb21hcC9idWZmZXJlZC1pby5jCj4gPiA+IGluZGV4IDNmMDkz
MmU0NmZkNi4uMGFhOGFiYzQzOGMxIDEwMDY0NAo+ID4gPiAtLS0gYS9mcy9pb21hcC9idWZmZXJl
ZC1pby5jCj4gPiA+ICsrKyBiL2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMKPiA+ID4gQEAgLTYyNiw3
ICs2MjYsNyBAQCBzdGF0aWMgaW50IGlvbWFwX3JlYWRfZm9saW9faXRlcihzdHJ1Y3QgaW9tYXBf
aXRlciAqaXRlciwKPiA+ID4gICAgICAgcmV0dXJuIDA7Cj4gPiA+ICB9Cj4gPiA+Cj4gPiA+IC12
b2lkIGlvbWFwX3JlYWRfZm9saW8oY29uc3Qgc3RydWN0IGlvbWFwX29wcyAqb3BzLAo+ID4gPiAr
dm9pZCBpb21hcF9yZWFkX2ZvbGlvKGlvbWFwX25leHRfZm4gaW9tYXBfbmV4dCwKPiA+Cj4gPiBJ
ZiB5b3UgdG9vayBteSBlYXJsaWVyIHN1Z2dlc3Rpb24gdG8gcmVuYW1lIHRoZSB0eXBlZGVmIHRv
Cj4gPiBpb21hcF9pdGVyX2ZuLCB0aGVuIHRoaXMgcGFyYW1ldGVyIG91Z2h0IHRvIGJlIG5hbWVk
IGl0ZXJfZm4uCj4gCj4gSG1tLi4uIG1heWJlIGF0IHRoYXQgcG9pbnQsIGl0J3Mgc2VsZi1leHBs
YW5hdG9yeSBlbm91Z2ggdGhhdCB0aGUgYXJnCj4gY291bGQganVzdCBiZSBjYWxsZWQgIml0ZXIi
IGluc3RlYWQgb2YgIml0ZXJfZm4iPwoKRHVubm8uICBTZWVpbmcgYXMgd2UgYWxyZWFkeSBoYXZl
IHZhcmlhYmxlcyBuYW1lZCAiaXRlciIgdGhhdCBhcmUgdGhlCmFjdHVhbCBpdGVyYXRpb24gc3Rh
dGUgb2JqZWN0LCBJIHRoaW5rIGl0J3MgY2xlYXJlciB0byBsZWF2ZSB0aGUKaXRlcmF0aW9uIGZ1
bmN0aW9uIGFzICJpdGVyX2ZuIi4KCj4gPgo+ID4gPiAgICAgICAgICAgICAgIHN0cnVjdCBpb21h
cF9yZWFkX2ZvbGlvX2N0eCAqY3R4LCB2b2lkICpwcml2YXRlKQo+ID4gPiAgewo+ID4gPiAgICAg
ICBzdHJ1Y3QgZm9saW8gKmZvbGlvID0gY3R4LT5jdXJfZm9saW87Cj4gPiA+IEBAIC02NTAsNyAr
NjUwLDcgQEAgdm9pZCBpb21hcF9yZWFkX2ZvbGlvKGNvbnN0IHN0cnVjdCBpb21hcF9vcHMgKm9w
cywKPiA+ID4gICAgICAgICAgICAgICBmc3Zlcml0eV9yZWFkYWhlYWQoY3R4LT52aSwgZm9saW8t
PmluZGV4LAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb2xpb19ucl9w
YWdlcyhmb2xpbykpOwo+ID4gPgo+ID4gPiAtICAgICB3aGlsZSAoKHJldCA9IGlvbWFwX2l0ZXIo
Jml0ZXIsIG9wcykpID4gMCkgewo+ID4gPiArICAgICB3aGlsZSAoKHJldCA9IGlvbWFwX2l0ZXIo
Jml0ZXIsIGlvbWFwX25leHQpKSA+IDApIHsKPiA+ID4gICAgICAgICAgICAgICBpdGVyLnN0YXR1
cyA9IGlvbWFwX3JlYWRfZm9saW9faXRlcigmaXRlciwgY3R4LAo+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmYnl0ZXNfc3VibWl0dGVkKTsKPiA+ID4gICAgICAgICAgICAgICBp
b21hcF9yZWFkX3N1Ym1pdCgmaXRlciwgY3R4KTsKPiA+ID4gQEAgLTY4OCwyMiArNjg4LDIyIEBA
IHN0YXRpYyBpbnQgaW9tYXBfcmVhZGFoZWFkX2l0ZXIoc3RydWN0IGlvbWFwX2l0ZXIgKml0ZXIs
Cj4gPiA+Cj4gPiA+ICAvKioKPiA+ID4gICAqIGlvbWFwX3JlYWRhaGVhZCAtIEF0dGVtcHQgdG8g
cmVhZCBwYWdlcyBmcm9tIGEgZmlsZS4KPiA+ID4gLSAqIEBvcHM6IFRoZSBvcGVyYXRpb25zIHZl
Y3RvciBmb3IgdGhlIGZpbGVzeXN0ZW0uCj4gPiA+ICsgKiBAaW9tYXBfbmV4dDogVGhlIGlvbWFw
X25leHQgY2FsbGJhY2sgZm9yIHRoZSBmaWxlc3lzdGVtLgo+ID4KPiA+ICJUaGUgaW9tYXAgaXRl
cmF0aW9uIGZ1bmN0aW9uIGZvciB0aGUgZmlsZXN5c3RlbSIgPwo+ID4KPiA+IFVzaW5nIHRoZSB0
ZXJtICJpb21hcF9uZXh0IiBpbiB0aGUgZGVmaW5pdGlvbiBmb3IgaW9tYXBfbmV4dCBpc24ndCB0
aGF0Cj4gPiBoZWxwZnVsLgo+IAo+IEFncmVlZCwgSSdsbCByZXBsYWNlIHRoaXMgd2l0aCB5b3Vy
IHN1Z2dlc3Rpb24uCgo8bm9kPgoKPiA+Cj4gPiA+ICAgICAgIHJldHVybiByZXQ7Cj4gPiA+IEBA
IC04MjQsMTYgKzgyNCwxNiBAQCB4ZnNfZmlsZV9kaW9fd3JpdGVfYXRvbWljKAo+ID4gPiAgICAg
ICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBpb2xvY2sgPSBYRlNfSU9MT0NLX1NIQVJFRDsKPiA+
ID4gICAgICAgc3NpemVfdCAgICAgICAgICAgICAgICAgcmV0LCBvY291bnQgPSBpb3ZfaXRlcl9j
b3VudChmcm9tKTsKPiA+ID4gICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgZGlvX2ZsYWdz
ID0gMDsKPiA+ID4gLSAgICAgY29uc3Qgc3RydWN0IGlvbWFwX29wcyAgKmRvcHM7Cj4gPiA+ICsg
ICAgIGlvbWFwX25leHRfZm4gICAgICAgICAgIGRvcHM7Cj4gPiA+Cj4gPiA+ICAgICAgIC8qCj4g
PiA+ICAgICAgICAqIEhXIG9mZmxvYWQgc2hvdWxkIGJlIGZhc3Rlciwgc28gdHJ5IHRoYXQgZmly
c3QgaWYgaXQgaXMgYWxyZWFkeQo+ID4gPiAgICAgICAgKiBrbm93biB0aGF0IHRoZSB3cml0ZSBs
ZW5ndGggaXMgbm90IHRvbyBsYXJnZS4KPiA+ID4gICAgICAgICovCj4gPiA+ICAgICAgIGlmIChv
Y291bnQgPiB4ZnNfaW5vZGVfYnVmdGFyZyhpcCktPmJ0X2F3dV9tYXgpCj4gPiA+IC0gICAgICAg
ICAgICAgZG9wcyA9ICZ4ZnNfYXRvbWljX3dyaXRlX2Nvd19pb21hcF9vcHM7Cj4gPiA+ICsgICAg
ICAgICAgICAgZG9wcyA9IHhmc19hdG9taWNfd3JpdGVfY293X2lvbWFwX25leHQ7Cj4gPiA+ICAg
ICAgIGVsc2UKPiA+ID4gLSAgICAgICAgICAgICBkb3BzID0gJnhmc19kaXJlY3Rfd3JpdGVfaW9t
YXBfb3BzOwo+ID4gPiArICAgICAgICAgICAgIGRvcHMgPSB4ZnNfZGlyZWN0X3dyaXRlX2lvbWFw
X25leHQ7Cj4gPgo+ID4gUHJvYmFibHkgb3VnaHQgdG8gYmUgY2FsbGVkIGl0ZXJfZm4sIG9yIGF0
IGxlYXN0IHNvbWV0aGluZyB0aGF0IGlzbid0Cj4gPiAiZG9wcyIuCj4gCj4gTmljZSBzcG90dGlu
ZywgSSdsbCByZW5hbWUgdGhpcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKPG5vZD4KCi0tRAoKPiBU
aGFua3MsCj4gSm9hbm5lCj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
