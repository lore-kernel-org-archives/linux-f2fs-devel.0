Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C03FD8FE0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YjuNU90J0LLjYMq7YAeiTjni1Dpra/vsFlpHzDZ/x5Q=; b=JxnoXgVoLQ7h/esfg2DC0x1Zg7
	JWNwzdbxf07j+ncIxNKwjK+jiMhb8C6EYyXWcrpQspOu4YVsZt2DF/S0c58fT1KD/BNMkRWj1sWPX
	zqyWL9EYBny42gQaCrMf9u6EUOhrmByN0ykScmWfW3yGdamAP+cexU++/tl0p1SYnaHQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvetX-0004mb-NW;
	Thu, 26 Feb 2026 17:11:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1vvetW-0004mV-Aa
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 17:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M8csZr2EQgc5N3LRaH5ivagOwuXzf8UvC8RjMLY1sRU=; b=dBdJlN1tYY21ZhlE21NFgnYRm0
 9XMeF9KTYLNNZ+lColfkeSQULBsgIMgkJt9gEWs1hzG8fzV4P1PUqfXpuH9B11wOfn60lVbjoeTpc
 sUO3GPJJv6CDvFAAS6ewkj7DjMSwmIFYMPskiVd8XOyropWocmyZcPvFJepUXEscCgkM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M8csZr2EQgc5N3LRaH5ivagOwuXzf8UvC8RjMLY1sRU=; b=LSBJTRMeyw4sw4G9DRkd6VZD1w
 p7GzteAmsKwZ2KC93dE0bT6Jw0DO2rRL/kj91J56VyFj5NmCJefmMPQW4+NN4YWhxb2IU5S3zOAGd
 jVx3QXzGXE94QT4HpW0sTGlaxCk2xpdW5cXqvB5b19poHAP5Pnpk8S2wyZskIP6QuzLQ=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vvetV-0001v9-Ct for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 17:11:22 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A6EE11FA8E;
 Thu, 26 Feb 2026 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772125874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8csZr2EQgc5N3LRaH5ivagOwuXzf8UvC8RjMLY1sRU=;
 b=bLq8scXnwXC0vwEJ5ilKWXpiGzWGXINIRxQGuAPYznnzF8dJ7yEAGsRN1FXFSCo0wMOtEw
 R1r7iRQfHNM8PtehEoACNOxGhhYttQpUUfNxxp1s2Wvc9j05A7FUEFY5faSoAqQhjduxby
 hGwdqMrN8ovxNjwcyfxmNJZvL2UdNBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772125874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8csZr2EQgc5N3LRaH5ivagOwuXzf8UvC8RjMLY1sRU=;
 b=AUyzYfQ90XcSZmOs/v84BZ0D0IAVBm4VSfgx0h3wTW4vNmvkFtLxsrW/okGqwdCnF/6uEc
 +rRoz6E13pCoehCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bLq8scXn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AUyzYfQ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772125874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8csZr2EQgc5N3LRaH5ivagOwuXzf8UvC8RjMLY1sRU=;
 b=bLq8scXnwXC0vwEJ5ilKWXpiGzWGXINIRxQGuAPYznnzF8dJ7yEAGsRN1FXFSCo0wMOtEw
 R1r7iRQfHNM8PtehEoACNOxGhhYttQpUUfNxxp1s2Wvc9j05A7FUEFY5faSoAqQhjduxby
 hGwdqMrN8ovxNjwcyfxmNJZvL2UdNBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772125874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8csZr2EQgc5N3LRaH5ivagOwuXzf8UvC8RjMLY1sRU=;
 b=AUyzYfQ90XcSZmOs/v84BZ0D0IAVBm4VSfgx0h3wTW4vNmvkFtLxsrW/okGqwdCnF/6uEc
 +rRoz6E13pCoehCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EC4B3EA62;
 Thu, 26 Feb 2026 17:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cu1uIrJ+oGlERwAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 17:11:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 1EDF2A0A27; Thu, 26 Feb 2026 18:11:06 +0100 (CET)
Date: Thu, 26 Feb 2026 18:11:06 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Message-ID: <6exhq5gjvef5obfsqwkxfcpl2sjqmlv7klrzolodzpcjolgrmd@ds42ulhod7pw>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-3-ccceff366db9@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260226-iino-u64-v1-3-ccceff366db9@kernel.org>
X-Spamd-Bar: /
X-Rspamd-Queue-Id: A6EE11FA8E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:viro@zeniv.linux.org.uk, m:jack@suse.cz,
 m:rostedt@goodmis.org, m:mathieu.desnoyers@efficios.com,
 m:dan.j.williams@intel.com, m:willy@infradead.org, m:osalvador@suse.de,
 m:dhowells@redhat.com, m:adilger.kernel@dilger.ca, m:jack@suse.com,
 m:neil@brown.name, m:okorniev@redhat.com, m:tom@talpey.com,
 m:sfrench@samba.org, m:ronniesahlberg@gmail.com, m:alex.aring@gmail.com,
 m:konishi.ryusuke@gmail.com, m:slava@dubeyko.com, m:lucho@ionkov.net,
 m:asmadeus@codewreck.org, m:linux_oss@crudebyte.com, m:dsterba@suse.com,
 m:marc.dionne@auristor.com, m:raven@themaw.net, m:salah.triki@gmail.com,
 m:aivazian.tigran@gmail.com, m:idryomov@gmail.com, m:amarkuze@redhat.com,
 m:jaharkes@cs.cmu.edu, m:coda@cs.cmu.edu, m:nico@fluxnic.net,
 m:code@tyhicks.com, m:amir73il@gmail.com, m:hch@infradead.org,
 m:glaubitz@physik.fu-berlin.de, m:frank.li@vivo.com,
 m:mikulas@artax.karlin.mff.cuni.cz, m:dwmw2@infradead.org,
 m:almaz.alexandrovich@paragon-software.com, m:mark@fasheh.com,
 m:jlbec@evilplan.org, m:miklos@szeredi.hu, m:al@alar
 sen.net, m:chengzhihao1@huawei.com, m:naohiro.aota@wdc.com,
 m:john.johansen@canonical.com, m:paul@paul-moore.com, m:serge@hallyn.com,
 m:roberto.sassu@huawei.com, m:dmitry.kasatkin@gmail.com,
 m:stephen.smalley.work@gmail.com, m:omosnace@redhat.com,
 m:casey@schaufler-ca.com, m:alexander.deucher@amd.com,
 m:christian.koenig@amd.com, m:airlied@gmail.com, m:simona@ffwll.ch,
 m:edumazet@google.com, m:kuniyu@google.com, m:pabeni@redhat.com,
 m:willemb@google.com, m:davem@davemloft.net, m:oleg@redhat.com,
 m:peterz@infradead.org, m:mingo@redhat.com, s:linux-mm@kvack.org,
 s:james.clark@linaro.org, s:alexander.shishkin@linux.intel.com,
 s:amd-gfx@lists.freedesktop.org, s:dri-devel@lists.freedesktop.org,
 s:linux-afs@lists.infradead.org, s:linux-mtd@lists.infradead.org,
 s:linaro-mm-sig@lists.linaro.org, s:fsverity@lists.linux.dev,
 s:netfs@lists.linux.dev, s:ntfs3@lists.linux.dev, s:nvdimm@lists.linux.dev,
 s:ocfs2-devel@lists.linux.dev, s:v9fs@lists.linux.dev,
 s:devel@lists.orangefs.org, s:samba-technical@lists.samba.org,
 s:jfs-discussion
 @lists.sourceforge.net,s:linux-f2fs-devel@lists.sourceforge.net,s:apparmor@lists.ubuntu.com];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
 RCPT_COUNT_GT_50(0.00)[146];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 R_RATELIMIT(0.00)[to_ip_from(RL1uz4ghne7c4p595ugmmfw3g8)];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Headers-End: 1vvetV-0001v9-Ct
Subject: Re: [f2fs-dev] [PATCH 03/61] trace: update VFS-layer trace events
 for u64 i_ino
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
 linux-hams@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Mike Marshall <hubcap@omnibond.com>, linux-xfs@vger.kernel.org,
 Fan Wu <wufan@kernel.org>, ceph-devel@vger.kernel.org,
 James Morris <jmorris@namei.org>, Tyler Hicks <code@tyhicks.com>,
 Christoph Hellwig <hch@infradead.org>, devel@lists.orangefs.org,
 Shyam Prasad N <sprasad@microsoft.com>, Martin Schiller <ms@dev.tdt.de>,
 Jan Harkes <jaharkes@cs.cmu.edu>, Willem de Bruijn <willemb@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-fscrypt@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 David Hildenbrand <david@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Jan Kara <jack@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 linux-media@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Dave Kleikamp <shaggy@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-cifs@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-nilfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 codalist@coda.cs.cmu.edu, linux-trace-kernel@vger.kernel.org,
 Olga Kornievskaia <okorniev@redhat.com>, Yangtao Li <frank.li@vivo.com>,
 selinux@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Casey Schaufler <casey@schaufler-ca.com>, netfs@lists.linux.dev,
 Jaegeuk Kim <jaegeuk@kernel.org>, fsverity@lists.linux.dev,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>,
 Muchun Song <muchun.song@linux.dev>, Roberto Sassu <roberto.sassu@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Anna Schumaker <anna@kernel.org>,
 linux-integrity@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>,
 Martin Brandenburg <martin@omnibond.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 ocfs2-devel@lists.linux.dev, jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 Ian Kent <raven@themaw.net>, Naohiro Aota <naohiro.aota@wdc.com>,
 Eric Biggers <ebiggers@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, coda@cs.cmu.edu,
 Viacheslav Dubeyko <slava@dubeyko.com>, NeilBrown <neil@brown.name>,
 Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Amir Goldstein <amir73il@gmail.com>,
 James Clark <james.clark@linaro.org>, autofs@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Damien Le Moal <dlemoal@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org,
 samba-technical@lists.samba.org, Ondrej Mosnacek <omosnace@redhat.com>,
 Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ian Rogers <irogers@google.com>, Alexander Aring <alex.aring@gmail.com>,
 Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 linux-f2fs-devel@lists.sourceforge.net, David Airlie <airlied@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, linux-x25@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Salah Triki <salah.triki@gmail.com>,
 Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com,
 Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 David Sterba <dsterba@suse.com>, Namhyung Kim <namhyung@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 John Johansen <john.johansen@canonical.com>,
 Luis de Bethencourt <luisbg@kernel.org>, netdev@vger.kernel.org,
 v9fs@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
 linux-security-module@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu 26-02-26 10:55:05, Jeff Layton wrote:
> Update trace event definitions in VFS-layer trace headers to use u64
> instead of ino_t/unsigned long for inode number fields, and change
> format strings from %lu/%lx to %llu/%llx to match.
> 
> This is needed because i_ino is now u64. Changing trace event field
> types changes the binary trace format, but the self-describing format
> metadata handles this transparently for modern trace-cmd and perf.
> 
> Files updated:
>   - cachefiles.h, filelock.h, filemap.h, fs_dax.h, fsverity.h,
>     hugetlbfs.h, netfs.h, readahead.h, timestamp.h, writeback.h
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

...

> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 4d3d8c8f3a1bc3e5ef10fc96e3c6dbbd0cf00c98..cc7651749eb3ce1123cb3ea9496f0803a0f4c1a0 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -67,7 +67,7 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
>  
>  	TP_STRUCT__entry (
>  		__array(char, name, 32)
> -		__field(ino_t, ino)
> +		__field(u64, ino)
>  		__field(pgoff_t, index)
>  	),
>  
> @@ -79,9 +79,9 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
>  		__entry->index = folio->index;
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu index=%lu",
> +	TP_printk("bdi %s: ino=%llu index=%lu",
>  		__entry->name,
> -		(unsigned long)__entry->ino,
> +		(unsigned long long)__entry->ino,

No need for explicit typing to ULL?

>  		__entry->index
>  	)
>  );
> @@ -108,7 +108,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>  
>  	TP_STRUCT__entry (
>  		__array(char, name, 32)
> -		__field(ino_t, ino)
> +		__field(u64, ino)
>  		__field(unsigned long, state)
>  		__field(unsigned long, flags)
>  	),
> @@ -123,9 +123,9 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>  		__entry->flags		= flags;
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu state=%s flags=%s",
> +	TP_printk("bdi %s: ino=%llu state=%s flags=%s",
>  		__entry->name,
> -		(unsigned long)__entry->ino,
> +		(unsigned long long)__entry->ino,

And here as well? And many times below as well...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
