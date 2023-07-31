Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E7CC001DE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Jul 2023 10:50:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qQQUH-0002in-CW;
	Mon, 31 Jul 2023 10:50:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1qQQUC-0002iK-Hq;
 Mon, 31 Jul 2023 10:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PJDu3H9G0xjlLFp1Wxvq9yQHkB2Q9jBIbPsGkP5jLhY=; b=RjpPPwwRhOoEs1bbANMUvsZkdP
 6cI5koSDZR8H1r5tLOrRD7brzJNjCWDiKPurBGNibXmMXHf+Qz5JTq4GO5cjEy8cpJg9brUK4dVjJ
 mkjvuWryq1M2vQ+HwyNQXgJ0hTCYPf9EJCalDEZ5ETYTC3wkt5pFMDkIgfOpmWEMp0uE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PJDu3H9G0xjlLFp1Wxvq9yQHkB2Q9jBIbPsGkP5jLhY=; b=eGrhVZT7I6HoyX28r8Sk8qBDCL
 XkWRK/r5kh4qQXVEgCA51S+fA6qvzod3VgnHOfxOq2GhaQ+9ja8mbGtXNhdUv3jonZYrumqeC1i7e
 vViiookjc1CSNsr5ZnCHpWhgwubQ6lOZSy1ViASyUiRON2EITqK7uTaotaCZhVzBwBGE=;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qQQU9-0000xJ-Bt; Mon, 31 Jul 2023 10:50:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED50E22197;
 Mon, 31 Jul 2023 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690800635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJDu3H9G0xjlLFp1Wxvq9yQHkB2Q9jBIbPsGkP5jLhY=;
 b=LfsIvVgX25rf01P6sVcmZRL3nPMT3sPJRPMrpOspwMqpMg9mmQx6AkDi/eF6WU32a2Vp6x
 /7YLD1OJK0u+bqfGa4P87gaOpA6/QZlHA1eZkenSQs1V9CjuRPICqxTQ9KdHYFZ84hOqsV
 4L46K3Rf4+bEtg2brIa/aboXrQrqviE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690800635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJDu3H9G0xjlLFp1Wxvq9yQHkB2Q9jBIbPsGkP5jLhY=;
 b=X5g/KyOpcE2CiMGegP9N6Ypxz5sWUyAuayNnMILk5q3XabEg0BuGZ7c8jHqKycooaqKD7s
 Ajq9KEorZZBfWcDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6932133F7;
 Mon, 31 Jul 2023 10:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ovhUNPqRx2R2ZgAAMHmgww
 (envelope-from <jack@suse.cz>); Mon, 31 Jul 2023 10:50:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 457F5A0767; Mon, 31 Jul 2023 12:50:34 +0200 (CEST)
Date: Mon, 31 Jul 2023 12:50:34 +0200
From: Jan Kara <jack@suse.cz>
To: Haris Iqbal <haris.iqbal@ionos.com>
Message-ID: <20230731105034.43skhi5ubze563c3@quack3>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
 <ZKbgAG5OoHVyUKOG@infradead.org>
 <CAJpMwyiUcw+mH0sZa8f8UJsaSZ7NSE65s2gZDEia+pASyP_gJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJpMwyiUcw+mH0sZa8f8UJsaSZ7NSE65s2gZDEia+pASyP_gJQ@mail.gmail.com>
X-Headers-End: 1qQQU9-0000xJ-Bt
Subject: Re: [f2fs-dev] [PATCH 01/32] block: Provide blkdev_get_handle_*
 functions
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
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
 Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-nvme@lists.infradead.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, Jack Wang <jinpu.wang@ionos.com>,
 Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xenproject.org,
 Gao Xiang <xiang@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org,
 Mike Snitzer <snitzer@kernel.org>, Joern Engel <joern@lazybastard.org>,
 reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
 linux-mm@kvack.org, Song Liu <song@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkIDEyLTA3LTIzIDE4OjA2OjM1LCBIYXJpcyBJcWJhbCB3cm90ZToKPiBPbiBUaHUsIEp1
bCA2LCAyMDIzIGF0IDU6MzjigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5v
cmc+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDAyOjIxOjI4UE0gKzAy
MDAsIEphbiBLYXJhIHdyb3RlOgo+ID4gPiBDcmVhdGUgc3RydWN0IGJkZXZfaGFuZGxlIHRoYXQg
Y29udGFpbnMgYWxsIHBhcmFtZXRlcnMgdGhhdCBuZWVkIHRvIGJlCj4gPiA+IHBhc3NlZCB0byBi
bGtkZXZfcHV0KCkgYW5kIHByb3ZpZGUgYmxrZGV2X2dldF9oYW5kbGVfKiBmdW5jdGlvbnMgdGhh
dAo+ID4gPiByZXR1cm4gdGhpcyBzdHJ1Y3R1cmUgaW5zdGVhZCBvZiBwbGFpbiBiZGV2IHBvaW50
ZXIuIFRoaXMgd2lsbAo+ID4gPiBldmVudHVhbGx5IGFsbG93IHVzIHRvIHBhc3Mgb25lIG1vcmUg
YXJndW1lbnQgdG8gYmxrZGV2X3B1dCgpIHdpdGhvdXQKPiA+ID4gdG9vIG11Y2ggaGFzc2xlLgo+
ID4KPiA+IENhbiB3ZSB1c2UgdGhlIG9wcG9ydHVuaXR5IHRvIGNvbWUgdXAgd2l0aCBiZXR0ZXIg
bmFtZXM/ICBibGtkZXZfZ2V0XyoKPiA+IHdhcyBhbHdheXMgYSByYXRoZXIgaG9ycmlibGUgbmFt
aW5nIGNvbnZlbnRpb24gZm9yIHNvbWV0aGluZyB0aGF0Cj4gPiBlbmRzIHVwIGNhbGxpbmcgaW50
byAtPm9wZW4uCj4gPgo+ID4gV2hhdCBhYm91dDoKPiA+Cj4gPiBzdHJ1Y3QgYmRldl9oYW5kbGUg
KmJkZXZfb3Blbl9ieV9kZXYoZGV2X3QgZGV2LCBibGtfbW9kZV90IG1vZGUsIHZvaWQgKmhvbGRl
ciwKPiA+ICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgYmxrX2hvbGRlcl9vcHMgKmhvcHMp
Owo+ID4gc3RydWN0IGJkZXZfaGFuZGxlICpiZGV2X29wZW5fYnlfcGF0aChkZXZfdCBkZXYsIGJs
a19tb2RlX3QgbW9kZSwKPiA+ICAgICAgICAgICAgICAgICB2b2lkICpob2xkZXIsIGNvbnN0IHN0
cnVjdCBibGtfaG9sZGVyX29wcyAqaG9wcyk7Cj4gPiB2b2lkIGJkZXZfcmVsZWFzZShzdHJ1Y3Qg
YmRldl9oYW5kbGUgKmhhbmRsZSk7Cj4gCj4gKzEgdG8gdGhpcy4KPiBBbHNvLCBpZiB3ZSBhcmUg
cmVtb3ZpbmcgImhhbmRsZSIgZnJvbSB0aGUgZnVuY3Rpb24sIHNob3VsZCB0aGUgbmFtZQo+IG9m
IHRoZSBzdHJ1Y3R1cmUgaXQgcmV0dXJucyBhbHNvIGNoYW5nZT8gV291bGQgc29tZXRoaW5nIGxp
a2UgYmRldl9jdHgKPiBiZSBiZXR0ZXI/CgpJIHRoaW5rIHRoZSBiZGV2X2hhbmRsZSBuYW1lIGlz
IGZpbmUgZm9yIHRoZSBzdHJ1Y3QuIEFmdGVyIGFsbCBpdCBpcwplcXVpdmFsZW50IG9mIGFuIG9w
ZW4gaGFuZGxlIGZvciB0aGUgYmxvY2sgZGV2aWNlIHNvIElNSE8gYmRldl9oYW5kbGUKY2FwdHVy
ZXMgdGhhdCBiZXR0ZXIgdGhhbiBiZGV2X2N0eC4KCgkJCQkJCQkJSG9uemEKLS0gCkphbiBLYXJh
IDxqYWNrQHN1c2UuY29tPgpTVVNFIExhYnMsIENSCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
