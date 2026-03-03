Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AC1EB3659
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B4LcQhJvhhdRGEGb7aaihOUBichuMnoe3DodFSClBiY=; b=YgCLbnv89W6vEX2KMvSwo1oq5c
	aRjN0Bq+DKQ7LxBrcmlSYF6Q/nKxzSTPBOnB5gKPFrBPYNrMuIhHNLfa/110cMxoUoo0iEzkb6kiM
	bMsr4gxb3asDDFWCnjI3oaqGfO1kdvkyWKu09zzveWAzFIp9EkXjBug9WS2gfkB2KJEE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxFcF-00035i-GG;
	Tue, 03 Mar 2026 02:36:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <paul@paul-moore.com>) id 1vxFcE-00035Z-8L
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 02:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=; b=F4yOy4wyXBq1ipa2xnNluvAT8e
 j9r2M82mVS7Ez7CSLcwyU/SqsYd7HuRIsK4/Kdql/PanmjasHSvtiraQip7wmz00G98eTLLB4f4Fb
 fp2VKCtjOVY9ZksIktC5dCaAsx44yQeOE6iuHS/rnugupW643lPE/iSV29O8r256Iw8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=; b=EuHkNIVkUn/s/8F1ayCp+UvjfI
 /TAyrwyGR2/MZHWQIv//QjPwPYNpQ/ff4buQCv2WiD4zELXP/Kiqiy0Qf7G5GoQaKdB0GObITZQA/
 s9IeIOoXi+Ro5oHSoWPIkhBcW4IVpiuhmJhWQ69g9qFijpz8b3Qv0dAtuPxV9QPMrq5o=;
Received: from mail-qt1-f172.google.com ([209.85.160.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vxFcD-0003JM-Tm for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 02:36:06 +0000
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-506a93ba42dso57207431cf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Mar 2026 18:36:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772505355; cv=none;
 d=google.com; s=arc-20240605;
 b=T/yGR8Stil2kXq9WqHiRuxapQn6HZtErsc/uI29K7mlkvMOjHqUamHjchQKpSZspoT
 MHwsc+skFXq2MqJ0u13m1OkVEwHM6IFB/YmK9gf1j1Ku6nmkEazICWIagy6WPpj8+QLv
 +vBI7KwQwAZS49uQjXqO3SRuJ0GDohFwkNmAZyyU4FibF4awAnzPP3PqBXhDwhzchzLV
 5m98+wqeFp2JGRvCMhEE09ZoABBvpQQ6TLdWQXiURV1ff2NhoDT9kyBHS08MYWOjTF1s
 wowZIi6A1/geITovRtllrjqeoibDUAE0o2JVFjC6S4vTGvpRCi5AU11a/dHX9yDzfATP
 Tg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=;
 fh=nk05rTQC/7yUj+rVuYsGksI1bKC2/7JiT10s6E18B3Y=;
 b=ModSATbZGid6L3XvySWVWxd2xy4i1cx4ZMGsLCdepimu9dGGvXGJj/5+YehWqjlTO3
 d/bJ2K82zS3Fu4Mpq/b/zS42ALJVynql3IIwYSmWr3+vZ+x52wbp+06W7p+QcdY36QeQ
 Z2iQbZDYWYI0ow5asLgvv9JTiHS91GiE+UAhe+/yD2cABHuFQw/NGg2qBBNTWxO8Y82+
 +3nChVHtbVIa1anqf8xzwfu1QIRN6G+3dOUI4w6qIgKm9FAKHl3LZsxliTXfTIGv6YLU
 jqJ/g58zitfekSHrPW1dQlh+ig3DTnPC0cS1OiLC0IyyezvwYagRYoACHWmxomOSAMPR
 Ovnw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore.com; s=google; t=1772505355; x=1773110155;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=;
 b=Y/KBT6SU45uQMux0fYh7MYou5fdRA5/Xprvk5Xvawb7ElZghQbiFhy6A5U6lBN5Irf
 O/NlWBhu51A3QVAkUpfbZ7Ol67ZAmc4z5rkiyoy+r3ewaKBJt7pA2Gg6EizpvKIC50vb
 X4RYRlduvnSzc50WABrZgJFL+k+Q46joFenQGL2ate6hkgNs8IR0Bdt8eSt+E4hXAbM+
 ok4MSvvSexgWmOalL6/6iyoJGyr/U/bAUo6hwjjX8t7li1DNglLsmj0GAmjvObaBZkbs
 4NOG2VrO27mIWzJXImP0HFuHzhMjew2XXw3Xcndt8Yc64XD1DCtNFRndzTFQZLB/xqaL
 I58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772505355; x=1773110155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=;
 b=ap78jX8awKfietrlnaR7lCWJwox5aDYPP32iePY5blU0xwyLYWJbzPDHguEImoKojs
 FKIsA2DYSah58ZLuhsvnQVFkHYGu8Oraq0n38Rh/rwbqo27VmuT/xNAYsvepIDSuLN0I
 +Q4zZPQTNU8dWMThprcY7ekhofkoWQ/0ZbHXyUKxXYw0a3RXKU89zwA11T7+BoWMAVVs
 +iGx/eCvaxGxtl5QF/jie2F4yYgtiJtoUwFmr+YOsrlhqRfI7SUcYNFAeB59vDgiLaM9
 ImrULKAsvma4kOF8s0JQQmM/yvjA85/4q8GQsJTFIukhLhlo+BYlxNjCE+8I33FCa6Wa
 nQ5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9GCGpyZzmwZ5iH9J3hq+q5HLPHBYboV9WYvKa+z0LWjqmNPyQfPM0F2w8DUk0sHEUbj1AyWnyESuiQdESrUte@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywcv0MNEySeD282Gy+0vBbIHn9D1ZJTj6xx5Z5rTFrfkiBCxrP0
 nVTZEyck1/8+UM6MZy1xwydDeld46dYqkLblhdPYEPjh78jMsgC62HpOq7/aCaWwg9nCudqa29u
 FMmLBRn0fU4ZzX2Jxe3dlsWPj3Eww5iutQxL8v2GVZlDw9l/DcmH+yA==
X-Gm-Gg: ATEYQzznI1sZv2daOkveGf2dCWOZ5gQ0dECXsCm5ChAqM5rZ5E4yhXQ+rTq4/WyUI+p
 5FVHj+lEEyNlpE5synUpuiKmM3Et97i4MH9wg8o2vJDT+Ag7bwm+3lbKXyvqWdLLG7s9dVCdS9H
 InnOTyJZwPSP9k0IJRelcUZtvQLQCk74wokqjvP4ZmzkY2pso9iMr5nr+gk5ryXiI2aHJlHGNxf
 aduRiEgSFFlNW0lpi2J3sAYpib5Q6vmrw2srMexGO5U/1pxRB4bbj0e/61+NOI/4djWobiUFtte
 iL1Q6x4=
X-Received: by 2002:a17:903:244a:b0:2ae:56f8:747b with SMTP id
 d9443c01a7336-2ae56f8786cmr37920855ad.57.1772505023451; Mon, 02 Mar 2026
 18:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-105-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-105-e5388800dae0@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Mar 2026 21:30:10 -0500
X-Gm-Features: AaiRm53tOqTCLn9NgvLgqwCOFo4xSyksjolr8ucn59RQ44Ck0r7mzGeRmSI5U0c
Message-ID: <CAHC9VhSHj7qc-tKxEN45bkfr+Dha59ihzOGiCO2WDYTYoB-LeA@mail.gmail.com>
To: Jeff Layton <jlayton@kernel.org>
X-Headers-End: 1vxFcD-0003JM-Tm
Subject: Re: [f2fs-dev] [PATCH v2 105/110] security: replace PRIino with
 %llu/%llx format strings
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, nvdimm@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Anders Larsen <al@alarsen.net>, dri-devel@lists.freedesktop.org,
 linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>, Mike Marshall <hubcap@omnibond.com>,
 linux-xfs@vger.kernel.org, Fan Wu <wufan@kernel.org>,
 Xin Long <lucien.xin@gmail.com>, ceph-devel@vger.kernel.org,
 James Morris <jmorris@namei.org>, Tyler Hicks <code@tyhicks.com>,
 Christoph Hellwig <hch@infradead.org>, devel@lists.orangefs.org,
 Shyam Prasad N <sprasad@microsoft.com>, Martin Schiller <ms@dev.tdt.de>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
 Willem de Bruijn <willemb@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-fscrypt@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 David Hildenbrand <david@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org,
 Eric Paris <eparis@redhat.com>, linux-perf-users@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-media@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Dave Kleikamp <shaggy@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-cifs@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-nilfs@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 codalist@coda.cs.cmu.edu, Remi Denis-Courmont <courmisch@gmail.com>,
 linux-trace-kernel@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Yangtao Li <frank.li@vivo.com>, selinux@vger.kernel.org, v9fs@lists.linux.dev,
 linux-can@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Casey Schaufler <casey@schaufler-ca.com>, netfs@lists.linux.dev,
 Jaegeuk Kim <jaegeuk@kernel.org>, fsverity@lists.linux.dev,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>,
 Muchun Song <muchun.song@linux.dev>, Roberto Sassu <roberto.sassu@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Anna Schumaker <anna@kernel.org>,
 linux-integrity@vger.kernel.org,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Alex Markuze <amarkuze@redhat.com>, Martin Brandenburg <martin@omnibond.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 ocfs2-devel@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 Marc Dionne <marc.dionne@auristor.com>, Neal Cardwell <ncardwell@google.com>,
 linux-afs@lists.infradead.org, Ian Kent <raven@themaw.net>,
 Naohiro Aota <naohiro.aota@wdc.com>, Eric Biggers <ebiggers@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, coda@cs.cmu.edu,
 Stanislav Fomichev <sdf@fomichev.me>, Viacheslav Dubeyko <slava@dubeyko.com>,
 NeilBrown <neil@brown.name>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, jfs-discussion@lists.sourceforge.net,
 "Serge E. Hallyn" <serge@hallyn.com>, Amir Goldstein <amir73il@gmail.com>,
 James Clark <james.clark@linaro.org>, autofs@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Damien Le Moal <dlemoal@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org,
 samba-technical@lists.samba.org, Ondrej Mosnacek <omosnace@redhat.com>,
 Steve French <sfrench@samba.org>, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, ntfs3@lists.linux.dev,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ian Rogers <irogers@google.com>, Alexander Aring <alex.aring@gmail.com>,
 Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 linux-f2fs-devel@lists.sourceforge.net, David Airlie <airlied@gmail.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-x25@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Mark Fasheh <mark@fasheh.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Salah Triki <salah.triki@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 Joerg Reuter <jreuter@yaina.de>, Simon Horman <horms@kernel.org>,
 apparmor@lists.ubuntu.com, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 David Sterba <dsterba@suse.com>, Namhyung Kim <namhyung@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 John Johansen <john.johansen@canonical.com>,
 Luis de Bethencourt <luisbg@kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, audit@vger.kernel.org,
 linux-security-module@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBNYXIgMiwgMjAyNiBhdCAzOjUw4oCvUE0gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBOb3cgdGhhdCBpX2lubyBpcyB1NjQgYW5kIHRoZSBQUklpbm8g
Zm9ybWF0IG1hY3JvIGhhcyBiZWVuIHJlbW92ZWQsCj4gcmVwbGFjZSBhbGwgdXNlcyBpbiBzZWN1
cml0eSB3aXRoIHRoZSBjb25jcmV0ZSBmb3JtYXQgc3RyaW5ncy4KPgo+IFNpZ25lZC1vZmYtYnk6
IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+Cj4gLS0tCj4gIHNlY3VyaXR5L2FwcGFy
bW9yL2FwcGFybW9yZnMuYyAgICAgICB8ICA0ICsrLS0KPiAgc2VjdXJpdHkvaW50ZWdyaXR5L2lu
dGVncml0eV9hdWRpdC5jIHwgIDIgKy0KPiAgc2VjdXJpdHkvaXBlL2F1ZGl0LmMgICAgICAgICAg
ICAgICAgIHwgIDIgKy0KPiAgc2VjdXJpdHkvbHNtX2F1ZGl0LmMgICAgICAgICAgICAgICAgIHwg
MTAgKysrKystLS0tLQo+ICBzZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMgICAgICAgICAgICAgfCAx
MCArKysrKy0tLS0tCj4gIHNlY3VyaXR5L3NtYWNrL3NtYWNrX2xzbS5jICAgICAgICAgICB8IDEy
ICsrKysrKy0tLS0tLQo+ICA2IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIwIGRl
bGV0aW9ucygtKQoKRm9yIHRoZSBMU00gZnJhbWV3b3JrIGFuZCBTRUxpbnV4IGNoYW5nZXMgLi4u
CgpBY2tlZC1ieTogUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4gKExTTS9TRUxpbnV4
KQoKLS0gCnBhdWwtbW9vcmUuY29tCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1k
ZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
