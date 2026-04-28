Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C7FF8867
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Apr 2026 01:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:Message-Id:To:Date:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L52zBrBpZIl8MXt6HjjXtmy+xG0fHW8WVDJwNJRWNzk=; b=mxBlJ+iqhSDX469sL4Sp/Gty6/
	Vet0Q/IS3uuZggmLNC7HxX9LsEtXJV4xLfkBxa+XVZNoJC6K0bLcLp4P/+fsqx75uI7dVG+VoiF2z
	RqiEeKO4H2tonrLcTU19L/+EbGqGsSBUp1aq907IG1I2P11p3Din7G4O9fTAcRh5JXi4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHXJU-00016x-Sc;
	Tue, 28 Apr 2026 01:32:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wHXJU-00016o-Ew
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 01:32:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:
 References:In-Reply-To:Message-Id:Cc:To:From:Date:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Ql5vxmUbx4YbATiW3f1uK+++/fsKuf/TvyrrtwZU3s=; b=lkS1ujLCjhQw1ezFdUCUyYGJmA
 Pg4es9yu+16MGoltTyuOh63WTKsnMf85w1ALq/dgTMV/d9OEhuILXG/JIoIh2XNnhVcpYnwsfCNuf
 N/bH1Vv9YKVmYHtxqM1DCHRsho/LXAMAtiemw/DDVPyc7SKNegMcOW9gKpiCngSNe27c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:References:In-Reply-To:
 Message-Id:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Ql5vxmUbx4YbATiW3f1uK+++/fsKuf/TvyrrtwZU3s=; b=EmEhJGgOuOglq5wB4rTnrdYcFW
 2p7d7Pf0Xm79jvivXSlBPfEwa/bYfCyBuUspe0MWUzYlix05TUfDxJhwWZw7aTfB8zxm8YudkgKZI
 rPz5BzW+5RBZy+UF8BWOiFctKqUHy+8jm3OiG8Lq7ijkPoAI1ZIGdNVdkOTh47uacuok=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHXJU-0001RN-IF for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 01:32:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 15EC043C21;
 Tue, 28 Apr 2026 01:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26348C4AF09;
 Tue, 28 Apr 2026 01:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777339946;
 bh=wHz+5U7YZ1YUh8S3O/ePJZetSOyRqZDheoo8PdaQubw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=TOhfDvzDaluU/j7Kds/kem7583xdqoHSELQ2x559IB9y0NQQNXIyzGBe6Fqbj/oYL
 HDM4jXg3bM9cjeEpaA6UdmNgruCW0rC5TyBRUOno+ir17RijO8NOgZqdoGNXn7XgIT
 EdF6NZGZUZgLwy74Fuq0NNuvvlu+7UwuiRf7BFCJxWEqwH0d15FUxo9qcUscCUFGNc
 BxRVwKIgWZ0PBiiG0NR9CjyM58Mb8CgM5Pj5NpqM0ptb7OY+g2TosBdIJpj7xTYFjv
 57pFveojlFHAesXaWck2CXVYspyIEIQiLPiM41p2XnkyOFZoB0mLHGNy9v7h0INder
 MX09Rw2Na6AMQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id 0EEA6F4006D;
 Mon, 27 Apr 2026 21:32:24 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-10.internal (MEProxy); Mon, 27 Apr 2026 21:32:24 -0400
X-ME-Sender: <xms:Jw7waTdxAlNGjpqkcmYs-AuhVm8o6a2ys9cH7oPKakERIjM35CzggQ>
 <xme:Jw7waUByBHZtpz_cO4UMWr0VoT7wNaP3SOQWx1_VsC9VZI3f0qKIOJlPWIqNFK_qx
 eTGs3Us4qmDCHQRAYK3eICv5OzGaEwL7XdPlGXhSJQN84a8D--lFa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
 ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
 eptdduhfeuteeileehtdegledvhfdvieefveelleeludelfeetvdfhteetjeetffdvnecu
 ffhomhgrihhnpehsrghshhhikhhordguvghvnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
 hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
 eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
 peefgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgvnhhoiihhrghtshhkhi
 estghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheprgguihhlghgvrhdrkhgvrhhnvghl
 seguihhlghgvrhdrtggrpdhrtghpthhtohepshhlrghvrgesughusggvhihkohdrtghomh
 dprhgtphhtthhopehrohhnnhhivghsrghhlhgsvghrghesghhmrghilhdrtghomhdprhgt
 phhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrh
 eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvmheskhgvrhhnvghlrdhorhhgpdhr
 tghpthhtoheptghhrghosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhngh
 eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Jw7waQ4Xow-t11J593OXzv-Gwl0Byd6MFv6z4UpYTD9UNKvdBWnqag>
 <xmx:KA7waYbam4XDlg9sbJKf1HWcmAANgKgDVgaJ3EUUVdDrsHM_F7ioEA>
 <xmx:KA7waSoQNfBCkKag9VRPAnKAGom1WVXc4rDrBOYssIOmltGlTsaAYg>
 <xmx:KA7wafIyNoQwaeh8KjYI0_7YlZVPbx8Hm9QpSej1pjj1LmcPjLYiZA>
 <xmx:KA7wadZV4ms4hY1uafi9BlfHPsflm006PYfpHyB8gesdt20AVsIDU3u9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id D0C61780075; Mon, 27 Apr 2026 21:32:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 27 Apr 2026 21:32:03 -0400
To: "Darrick J. Wong" <djwong@kernel.org>
Message-Id: <3fd6dcbf-ece6-459e-b114-1d8b95035acf@app.fastmail.com>
In-Reply-To: <20260427155636.GC7751@frogsfrogsfrogs>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <20260424-case-sensitivity-v11-8-de5619beddaf@oracle.com>
 <20260427155636.GC7751@frogsfrogsfrogs>
X-Headers-End: 1wHXJU-0001RN-IF
Subject: Re: [f2fs-dev] [PATCH v11 08/15] xfs: Report case sensitivity in
 fileattr_get
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@manguebit.org>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Carlos Maiolino <cem@kernel.org>,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Shyam Prasad N <sprasad@microsoft.com>,
 frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Christian Brauner <brauner@kernel.org>, Theodore Tso <tytso@mit.edu>,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, Hans de Goede <hansg@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CgpPbiBNb24sIEFwciAyNywgMjAyNiwgYXQgMTE6NTYgQU0sIERhcnJpY2sgSi4gV29uZyB3cm90
ZToKPiBPbiBGcmksIEFwciAyNCwgMjAyNiBhdCAwOTo1MzoxMFBNIC0wNDAwLCBDaHVjayBMZXZl
ciB3cm90ZToKPj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+Cj4+
IAo+PiBVcHBlciBsYXllcnMgc3VjaCBhcyBORlNEIG5lZWQgdG8gcXVlcnkgd2hldGhlciBhIGZp
bGVzeXN0ZW0KPj4gaXMgY2FzZS1zZW5zaXRpdmUuIEFkZCBGU19YRkxBR19DQVNFRk9MRCB0byB4
ZnNfaXAyeGZsYWdzKCkKPj4gd2hlbiB0aGUgZmlsZXN5c3RlbSBpcyBmb3JtYXR0ZWQgd2l0aCB0
aGUgQVNDSUlDSSBmZWF0dXJlCj4+IGZsYWcuIFRoaXMgc2VydmVzIGJvdGggRlNfSU9DX0ZTR0VU
WEFUVFIgKHZpYSB4ZnNfZmlsbF9mc3hhdHRyKCkgaW4KPj4geGZzX2ZpbGVhdHRyX2dldCgpKSBh
bmQgWEZTX0lPQ19CVUxLU1RBVCAod2hpY2ggcG9wdWxhdGVzIGJzX3hmbGFncwo+PiBkaXJlY3Rs
eSBmcm9tIHhmc19pcDJ4ZmxhZ3MoKSksIHNvIGJ1bGtzdGF0IGNvbnN1bWVycyBhbmQgcGVyLWlu
b2RlCj4+IHF1ZXJpZXMgc2VlIGEgY29uc2lzdGVudCB2aWV3IG9mIHRoZSBmaWxlc3lzdGVtJ3Mg
Y2FzZS1mb2xkaW5nCj4+IGJlaGF2aW9yLgo+PiAKPj4gWEZTIGFsd2F5cyBwcmVzZXJ2ZXMgY2Fz
ZS4gWEZTIGlzIGNhc2Utc2Vuc2l0aXZlIGJ5IGRlZmF1bHQsIGJ1dAo+PiBzdXBwb3J0cyBBU0NJ
SSBjYXNlLWluc2Vuc2l0aXZlIGxvb2t1cHMgd2hlbiBmb3JtYXR0ZWQgd2l0aCB0aGUKPj4gQVND
SUlDSSBmZWF0dXJlIGZsYWcuCj4+IAo+PiBSZXZpZXdlZC1ieTogUm9sYW5kIE1haW56IDxyb2xh
bmQubWFpbnpAbnJ1YnNpZy5vcmc+Cj4+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVj
ay5sZXZlckBvcmFjbGUuY29tPgo+PiAtLS0KCj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoaXMgYXQg
YWxsLiAgWWVzLCBGU19YRkxBR19DQVNFRk9MRCBpcyByZWFkb25seSwKPiBidXQgaG93IGRvZXMg
Y2xlYXJpbmcgRlNfQ0FTRUZPTERfRkwgZnJvbSB0aGUgZmlsZWF0dHJfZ2V0IG91dHB1dAo+ICh3
aXRob3V0IGNsZWFyaW5nIFhGTEFHX0NBU0VGT0xEISkgc29sdmUgYW55dGhpbmc/ICBUaGlzIG1h
a2VzIHRoZQo+IHJlcG9ydGVkIG91dHB1dCBpbmNvbnNpc3RlbnQgYmV0d2VlbiBmc2dldHhhdHRy
IGFuZCBnZXRmbGFncyAtLSBvbmUKPiByZXBvcnRzIGNhc2UgZm9sZGluZywgdGhlIG90aGVyIHJl
cG9ydHMgbm8gY2FzZWZvbGRpbmcuCgpUaGUgbWFza2luZyBpcyBhIG1pc3BsYWNlZCByZWFjdGlv
biB0byBhIHNhc2hpa28gcmV2aWV3IG9uIHRoZQp2OSBwcmVkZWNlc3NvciBvZiB0aGlzIHBhdGNo
IFsxXSwgd2hpY2ggcG9pbnRlZCBvdXQgdGhhdCB2OSBzZXQKRlNfWEZMQUdfQ0FTRUZPTEQgaW4g
ZmEtPmZzeF94ZmxhZ3MgYWZ0ZXIgeGZzX2ZpbGxfZnN4YXR0cigpIGhhZAphbHJlYWR5IHN5bmNl
ZCBmYS0+ZmxhZ3MsIGxlYXZpbmcgdGhlIHR3byB2aWV3cyBpbmNvbnNpc3RlbnQgaW4KdGhlIG90
aGVyIGRpcmVjdGlvbiwgYW5kIHRoYXQgYnVsa3N0YXQgd291bGQgbWlzcyB0aGUgZmxhZyBmb3IK
dGhlIHNhbWUgcmVhc29uLiBNb3ZpbmcgdGhlIGluamVjdGlvbiBpbnRvIHhmc19pcDJ4ZmxhZ3Mo
KSBmaXhlZApib3RoIGdhcHMgLS0gYnV0IGl0IGFsc28gc3VyZmFjZWQgRlNfQ0FTRUZPTERfRkwg
b24gdGhlIGxlZ2FjeQp2aWV3LCBzbyBjaGF0dHIncyBSTVcgdGhyb3VnaCBGU19JT0NfU0VURkxB
R1MgaGl0cyB0aGUgRU9QTk9UU1VQUApnYXRlIGF0IHRoZSB0b3Agb2YgeGZzX2ZpbGVhdHRyX3Nl
dCgpLiBIaWRpbmcgaXQgZnJvbSBnZXRmbGFncwp3YXMgdGhlIHdyb25nIHBsYWNlIHRvIGFkZHJl
c3MgdGhhdC4KCj4gSWYgeW91IHdhbnQgdG8gYXZvaWQgZmlsZWF0dHJfc2V0IHJldHVybmluZyBF
SU5WQUwgd2hlbiBzZXR0aW5nCj4gYXR0cmlidXRlcyBkdWUgdG8gdGhlIGNhc2Vmb2xkIGZsYWcs
IHRoZW4gZG9uJ3QgeW91IHdhbnQgdG8gY2hlY2sKPiB0aGUgZmxhZyBzdGF0ZSB2cy4geGZzX2hh
c19hc2NpaWNpKCkgaW4gdGhlICpmaWxlYXR0cl9zZXQqIHBhdGg/CgpZZXAuIEZvciB2MTIgSeKA
mWxsIGRyb3AgdGhlIGZhLT5mbGFncyBtYXNrIGFuZCBhZGQgRlNfQ0FTRUZPTERfRkwKdG8gdGhl
IGFsbG93bGlzdCBpbiB4ZnNfZmlsZWF0dHJfc2V0KCksIGdhdGVkIG9uIHhmc19oYXNfYXNjaWlj
aShtcCkuCnhmc19mbGFnczJkaWZsYWdzKCkgYWxyZWFkeSBoYXMgbm8gY2xhdXNlIGZvciBDQVNF
Rk9MRCwgc28gdGhlCkZTU0VUWEFUVFIgcGF0aCBzaWxlbnRseSBuby1vcHMgaXQgdGhlIHNhbWUg
d2F5IGl0IGRvZXMgZm9yCkZTX1hGTEFHX0hBU0FUVFIsIGFuZCBGU19YRkxBR19DQVNFRk9MRCBp
cyBpbiBGU19YRkxBR19SRE9OTFlfTUFTSwpzbyBGU1NFVFhBVFRSIHN0cmlwcyBpdCBjZW50cmFs
bHkuIEJvdGggdmlld3MgdGhlbiBhZ3JlZSwgYW5kIGEKY2hhdHRyIHJvdW5kLXRyaXAgaXMgYWNj
ZXB0ZWQgYXMgYSBuby1vcC4KClRoZSBoZnNwbHVzIHBhdGNoIGluIHRoaXMgc2VyaWVzIGNhcnJp
ZXMgdGhlIHNhbWUgcGF0dGVybiAtLQpGU19YRkxBR19DQVNFRk9MRCBpcyBzZXQgYWZ0ZXIgZmls
ZWF0dHJfZmlsbF9mbGFncygpIHNvIHRoYXQKRlNfQ0FTRUZPTERfRkwgc3RheXMgb3V0IG9mIGZh
LT5mbGFncyBhbmQgZG9kZ2VzIHRoZSBFT1BOT1RTVVBQCmdhdGUgaW4gaGZzcGx1c19maWxlYXR0
cl9zZXQoKS4gSSB3aWxsIGZpeCBpdCB0aGUgc2FtZSB3YXkuCgpUaGFua3MgZm9yIHRoZSBjYXRj
aCEKClsxXSBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA0MjItY2FzZS1zZW5z
aXRpdml0eS12OS0wLWJlMDIzY2MwNzBlMkBvcmFjbGUuY29tP3BhcnQ9OQoKCi0tIApDaHVjayBM
ZXZlcgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwK
