Return-Path: <SRS0=2yhi=W2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058DC3A59F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Aug 2019 01:33:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C77B21726;
	Fri, 30 Aug 2019 01:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jh/PDLUB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Xln4fllt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="rsF3TnYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C77B21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i3Vmp-0001Hf-Hy; Fri, 30 Aug 2019 01:33:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hubcap@omnibond.com>) id 1i3Vmo-0001HX-Bh
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Aug 2019 01:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TfZVE6zvYYuoOuB/Rxqa+Mlm3vtxZPY12krCFPSTtI=; b=jh/PDLUBlVRqPRJ1v5Ku95e6s9
 65SesTZ1aCQSglcdXjwK1kuhr4+bVOS74+z4Xj1U6NFKZYbK4XbAZvajAc9dk7x/efPZ7+AIV4IOt
 QuOuvoaAjmnxrlNf7a8Fuioz+8EpGdNnjK/HMCIrx09JLeJsCyIn3vq8/TcMF0nR/kIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4TfZVE6zvYYuoOuB/Rxqa+Mlm3vtxZPY12krCFPSTtI=; b=Xln4flltGyJXApiSAfqbnF1X2C
 HRHskOQCAjYkCfiaqz46f+TTtaLrUoXDPKF+3DOsmh5r27Z0Itm9QTwiBlcGzvADpRcpnZi3VQ3x0
 KtDkn0LG2QvQdEJWk6HEkizoQB4wmQaT/9DQvtSOAWiEB7hyMiG7AH9a4cchulgwe/98=;
Received: from mail-yw1-f66.google.com ([209.85.161.66])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1i3Vmm-008evP-Er
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Aug 2019 01:33:10 +0000
Received: by mail-yw1-f66.google.com with SMTP id n11so1844911ywn.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 29 Aug 2019 18:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=omnibond-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4TfZVE6zvYYuoOuB/Rxqa+Mlm3vtxZPY12krCFPSTtI=;
 b=rsF3TnYvnJjkhMrqd8jgi2b1fWfnS720m/snkWNYBAl3jogwp2mEsqA8h0meBBMFCG
 mupgLKrOXopsTT3mx+lDcAZLHUPbfCw/vXrZaEIvlfIiq4H0dj/IKCul0NWP4fpGLsu4
 48Lini1zfDu9D/EL0CeWiI8kZAXrgg08x+hcJWXhpsmSN701z4+zSsQ5V2A/N+PZ/ko+
 cAveXQxi5GTfOnxm/M0L2QMcpa0QpEp0UoezlsX6vklrx1noOLsykTvVpPGdg1yASetm
 NGCTD4uF7gFM2G4DP0Fj0jWpPyOxMpJF0KkXFU1tGtaTorkpzYDBwzJA49OyfPjy95xt
 U/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4TfZVE6zvYYuoOuB/Rxqa+Mlm3vtxZPY12krCFPSTtI=;
 b=HGN8XT/XD14PVpAkRQTVJ6mIPXKWfKteSobZqk/AxziSu5KtsJBBBvHUj1Vb0cezZg
 Af/npVgnrX/gXixDvZEWqib6xOl7PGTFy+jU4KlAGC30MDYu/vlCRiO6xjck4m2IO3wt
 NRJtV0rrD0TYolD+zNTa4Q0Qxg7uBlxraCeQIDqvFTgeCU9jhGV/XnJVqSFmo8q9wWKc
 H86tuBWX6jlFatWdtVPoSOhApFScjtmgnOrJ3F7nZvaZVS6QivgKUMmZ7ThxwdeiPEOU
 OzLzfvleRZMPvDdoix6FPngQeJ6s8h/bDieBS9sztvKUDKVVNI1hnqm8v94RSA/8rHgM
 Qu1w==
X-Gm-Message-State: APjAAAWEndRUFI/NZnrx/WBvPH9Y0V6NBh7RNTOS1Q/XDeWzFTODl7yl
 85A6jjk9J6F1E1xbRSEwS3jZfI4O8DC0GsIzgcFIAg==
X-Google-Smtp-Source: APXvYqwS/gBw6GYqWJhwCNBmHR6+W2ONQRTVjMY8ZXLyRIgVZbf1blJaiiDec2a/U/ArNO35ME5xZuocZ9cXu0GpPKQ=
X-Received: by 2002:a0d:d596:: with SMTP id x144mr9018446ywd.69.1567128290041; 
 Thu, 29 Aug 2019 18:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190827150544.151031-1-salyzyn@android.com>
 <20190828142423.GA1955@infradead.org>
 <5dd09a38-fffb-36f2-505b-be2ddf6bb750@android.com>
In-Reply-To: <5dd09a38-fffb-36f2-505b-be2ddf6bb750@android.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Thu, 29 Aug 2019 21:24:38 -0400
Message-ID: <CAOg9mSTCC4Z3RpEyppC50B+pnSBbV0sr-F7hbsM-B+z3c-AZVA@mail.gmail.com>
To: Mark Salyzyn <salyzyn@android.com>
X-Headers-End: 1i3Vmm-008evP-Er
Subject: Re: [f2fs-dev] [PATCH v8] Add flags option to get xattr method
 paired to __vfs_getxattr
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Hugh Dickins <hughd@google.com>,
 James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
 devel@lists.orangefs.org, Eric Van Hensbergen <ericvh@gmail.com>,
 Joel Becker <jlbec@evilplan.org>, Anna Schumaker <anna.schumaker@netapp.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Kleikamp <shaggy@kernel.org>,
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, linux-cifs@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 Eric Sandeen <sandeen@sandeen.net>, kernel-team@android.com,
 selinux@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 reiserfs-devel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Miklos Szeredi <miklos@szeredi.hu>, "Linux F2FS DEV,
 Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 Benjamin Coddington <bcodding@redhat.com>, linux-integrity@vger.kernel.org,
 Martin Brandenburg <martin@omnibond.com>, Chris Mason <clm@fb.com>,
 linux-mtd <linux-mtd@lists.infradead.org>, linux-afs@lists.infradead.org,
 Jonathan Corbet <corbet@lwn.net>, Vyacheslav Dubeyko <slava@dubeyko.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Serge Hallyn <serge@hallyn.com>,
 Eric Paris <eparis@parisplace.org>, ceph-devel <ceph-devel@vger.kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, samba-technical@lists.samba.org,
 linux-xfs@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com,
 jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 Eric Biggers <ebiggers@google.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Adrian Hunter <adrian.hunter@intel.com>, David Howells <dhowells@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, devel@driverdev.osuosl.org,
 "J. Bruce Fields" <bfields@redhat.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 cluster-devel@redhat.com, Steve French <sfrench@samba.org>,
 V9FS Developers <v9fs-developer@lists.sourceforge.net>,
 Bharath Vedartham <linux.bhar@gmail.com>, Jann Horn <jannh@google.com>,
 ecryptfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Dave Chinner <dchinner@redhat.com>, David Sterba <dsterba@suse.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, netdev@vger.kernel.org,
 linux-unionfs@vger.kernel.org, stable@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>, linux-security-module@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>,
 David Woodhouse <dwmw2@infradead.org>, linux-btrfs@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SSBhZGRlZCB0aGlzIHBhdGNoIHNlcmllcyBvbiB0b3Agb2YgTGludXggNS4zLXJjNiBhbmQgcmFu
IHhmc3Rlc3RzCm9uIG9yYW5nZWZzIHdpdGggbm8gcmVncmVzc2lvbnMuCgpBY2tlZC1ieTogTWlr
ZSBNYXJzaGFsbCA8aHViY2FwQG9tbmlib25kLmNvbT4KCi1NaWtlCgpPbiBXZWQsIEF1ZyAyOCwg
MjAxOSBhdCAxMDo0MCBBTSBNYXJrIFNhbHl6eW4gPHNhbHl6eW5AYW5kcm9pZC5jb20+IHdyb3Rl
Ogo+Cj4gT24gOC8yOC8xOSA3OjI0IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiA+IE9u
IFR1ZSwgQXVnIDI3LCAyMDE5IGF0IDA4OjA1OjE1QU0gLTA3MDAsIE1hcmsgU2FseXp5biB3cm90
ZToKPiA+PiBSZXBsYWNlIGFyZ3VtZW50cyBmb3IgZ2V0IGFuZCBzZXQgeGF0dHIgbWV0aG9kcywg
YW5kIF9fdmZzX2dldHhhdHRyCj4gPj4gYW5kIF9fdmZzX3NldGF4dHIgZnVuY3Rpb25zIHdpdGgg
YSByZWZlcmVuY2UgdG8gdGhlIGZvbGxvd2luZyBub3cKPiA+PiBjb21tb24gYXJndW1lbnQgc3Ry
dWN0dXJlOgo+ID4gWWlrZXMuICBUaGF0IGxvb2tzIGxpa2UgYSBtZXNzLiAgV2h5IGNhbid0IHdl
IHBhc3MgYSBrZXJuZWwtb25seQo+ID4gZmxhZyBpbiB0aGUgZXhpc3RpbmcgZmxhZ3MgZmllbGQg
Zm9yIOKCiz5zZXQgYW5kIGFkZCBhIGZsYWdzIGZpZWxkCj4gPiB0byAtPmdldD8gIFBhc3Npbmcg
bWV0aG9kcyBieSBzdHJ1Y3R1cmUgYWx3YXlzIHRlbmRzIHRvIGJlIGEgbWVzcy4KPgo+IFRoaXMg
d2FzIGEgcmVzcG9uc2UgdG8gR3JlZ0tIQCBjcml0aWNpc20sIGFuIGVhcmxpZXIgcGF0Y2ggc2V0
IGp1c3QKPiBhZGRlZCBhIGZsYWcgYXMgeW91IHN0YXRlZCB0byBnZXQgbWV0aG9kLCB1bnRpbCBj
b21wbGFpbnRzIG9mIGFuCj4gZXhjZXNzaXZlbHkgbG9uZyBhcmd1bWVudCBsaXN0IGFuZCBmcmFn
aWxpdHkgdG8gYWRkIG9yIGNoYW5nZSBtb3JlCj4gYXJndW1lbnRzLgo+Cj4gU28gbWFueSB3YXlz
IGhhdmUgYmVlbiB0cmllZCB0byBza2luIHRoaXMgY2F0IC4uLiB0aGUgcmlzayB3YXMgdGFrZW4g
dG8KPiBwbGVhc2Ugc29tZSwgYW5kIHdlIG5vdyBoYXZlIGh1bmRyZWRzIG9mIHN0YWtlaG9sZGVy
cywgd2hlbiB0aGUgZmlyc3QKPiBwYXRjaCBzZXQgd2FzIGxlc3MgdGhhbiBhIGRvemVuLiBBIHJl
Y2lwZSBmb3IgZmFpbHVyZT8KPgo+IC0tIE1hcmsKPgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
