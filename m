Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB083EC142E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7QR2ehH3T6/AkxdNa6Br70fwoykQDrXdKnkgcSpmuZ8=; b=YdL5b4sUDjN6HVCYDpyuxQutvY
	hQCm0sgtjtVs22KI1mytL+Cd4bFG3GsGTEQHmYxDzqLK0d9GjkiGbyOllcjMiqCFHX6sENysMHyus
	/P+oWuddfftibz/NSr2QdV+MDsFqlDX/a9wsMeu+ZwXrr4DZU6jZ+LUiE5VohZGd3dHg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxNpa-0001MO-Hu;
	Tue, 03 Mar 2026 11:22:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1vxNpZ-0001MB-EH
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 11:22:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KeUIkqizRv13GXqCMqsXZmgZff1w7sG5Qjbx6Jj7J7Q=; b=B2xiJ/MDVmM7BCFdKQ/q1v7a5I
 46jENzQmUYqTrZI+IL1mqF13JOkGYHxq576Mpyf2cHwxw8p9M7v37UD/aXcqR13G7LaxQx8lJlpIR
 NVbMguNJBpaHtKH8zNFsig9h1E6k5+uW4VxjKa3stJtHpJ+Ufz/aVhq0D+9nSn8niaMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KeUIkqizRv13GXqCMqsXZmgZff1w7sG5Qjbx6Jj7J7Q=; b=WMkWu7IGL2JpGpGhLvhbse7Yb+
 JG0OKj0eipMF+163lmmz9T6PQco3F65AorE1xjBefHJZkHeaGUqCUL2e+6Oz2hRSyKg8EIfc/iHIS
 VZ8kIe088ETAbQb+ti5xmNQlTqW5G9GNPJbi6tHBTc20LIpihySxI7G4ndxMp1JBqaAQ=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vxNpZ-0003bk-Fu for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 11:22:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 060B83F778;
 Tue,  3 Mar 2026 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772536934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KeUIkqizRv13GXqCMqsXZmgZff1w7sG5Qjbx6Jj7J7Q=;
 b=MMje5RHtAq0iyN2Ci5NB3siR+5uKf4OabgxeLPpbapGQwdYTZLHIG9WbEhBZtfZH4K6FJj
 K6dLcOOiweD5MCv526aROGLBnxAitX0xVEFukIg5VKf81+ODBL8aapNjjd2HAUQ3YbMqn7
 qxFG09Zg+uhBneAwqCoeimjK9RUv3zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772536934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KeUIkqizRv13GXqCMqsXZmgZff1w7sG5Qjbx6Jj7J7Q=;
 b=mBJ7uKd5M1QzjfrDgXpF0iEdCEhfwIvS8TCLCSzoZDho+dSibf/db1v1ycUm9i74WcZRv4
 dGapPbtCt8Qt4hAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772536934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KeUIkqizRv13GXqCMqsXZmgZff1w7sG5Qjbx6Jj7J7Q=;
 b=MMje5RHtAq0iyN2Ci5NB3siR+5uKf4OabgxeLPpbapGQwdYTZLHIG9WbEhBZtfZH4K6FJj
 K6dLcOOiweD5MCv526aROGLBnxAitX0xVEFukIg5VKf81+ODBL8aapNjjd2HAUQ3YbMqn7
 qxFG09Zg+uhBneAwqCoeimjK9RUv3zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772536934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KeUIkqizRv13GXqCMqsXZmgZff1w7sG5Qjbx6Jj7J7Q=;
 b=mBJ7uKd5M1QzjfrDgXpF0iEdCEhfwIvS8TCLCSzoZDho+dSibf/db1v1ycUm9i74WcZRv4
 dGapPbtCt8Qt4hAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFE453EA6C;
 Tue,  3 Mar 2026 11:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QZqiNmXEpmnxRwAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 11:22:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 9E82BA0A1B; Tue,  3 Mar 2026 12:22:13 +0100 (CET)
Date: Tue, 3 Mar 2026 12:22:13 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Message-ID: <ylcfz3i2lduxgi5sywsxolkk3yc6u5satyzrf2mymj2vcirtiy@bfgr5natl6gf>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-14-e5388800dae0@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260302-iino-u64-v2-14-e5388800dae0@kernel.org>
X-Spamd-Result: default: False [-0.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:jlayton@kernel.org, m:viro@zeniv.linux.org.uk,
 m:brauner@kernel.org, m:rostedt@goodmis.org, m:mhiramat@kernel.org,
 m:mathieu.desnoyers@efficios.com, m:dan.j.williams@intel.com,
 m:willy@infradead.org, m:ebiggers@kernel.org, m:muchun.song@linux.dev,
 m:david@kernel.org, m:adilger.kernel@dilger.ca, m:jaegeuk@kernel.org,
 m:chao@kernel.org, m:trondmy@kernel.org, m:anna@kernel.org, m:neil@brown.name,
 m:ronniesahlberg@gmail.com, m:alex.aring@gmail.com,
 m:konishi.ryusuke@gmail.com, m:slava@dubeyko.com, m:ericvh@kernel.org,
 m:lucho@ionkov.net, m:asmadeus@codewreck.org, m:linux_oss@crudebyte.com,
 m:marc.dionne@auristor.com, m:luisbg@kernel.org, m:salah.triki@gmail.com,
 m:aivazian.tigran@gmail.com, m:idryomov@gmail.com, m:jaharkes@cs.cmu.edu,
 m:coda@cs.cmu.edu, m:nico@fluxnic.net, m:amir73il@gmail.com,
 m:hch@infradead.org, m:frank.li@vivo.com, m:mikulas@artax.karlin.mff.cuni.cz,
 m:dwmw2@infradead.org, m:shaggy@kernel.org, m:mark@fasheh.com,
 m:jlbec@evilplan.org, m:joseph.qi@linux.alibaba.com, m:al@alarsen.net, 
 m:chengzhihao1@huawei.com, m:dlemoal@kernel.org, m:naohiro.aota@wdc.com,
 m:jth@kernel.org, m:john.johansen@canonical.com, m:serge@hallyn.com,
 m:zohar@linux.ibm.com, m:roberto.sassu@huawei.com, m:dmitry.kasatkin@gmail.com,
 m:wufan@kernel.org, m:stephen.smalley.work@gmail.com,
 m:alexander.deucher@amd.com, m:christian.koenig@amd.com, m:airlied@gmail.com,
 m:simona@ffwll.ch, m:sumit.semwal@linaro.org, m:edumazet@google.com,
 m:kuniyu@google.com, m:willemb@google.com, m:davem@davemloft.net,
 m:kuba@kernel.org, m:horms@kernel.org, m:peterz@infradead.org,
 m:acme@kernel.org, m:namhyung@kernel.org, s:nvdimm@lists.linux.dev,
 s:ocfs2-devel@lists.linux.dev, s:v9fs@lists.linux.dev,
 s:devel@lists.orangefs.org, s:samba-technical@lists.samba.org,
 s:jfs-discussion@lists.sourceforge.net,
 s:linux-f2fs-devel@lists.sourceforge.net, s:apparmor@lists.ubuntu.com,
 s:mkl@pengutronix.de, s:eparis@redhat.com, s:steffen.klassert@secunet.com,
 s:audit@vger.kernel.org, s:autofs@vger.kernel.org, s:bpf@vger.kernel.org,
 s:ceph-devel@vger.kernel.org, s:ecryptf
 s@vger.kernel.org,s:linux-bluetooth@vger.kernel.org,s:linux-can@vger.kernel.org,s:linux-cifs@vger.kernel.org];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 TAGGED_RCPT(0.00)[];
 FREEMAIL_CC(0.00)[zeniv.linux.org.uk, kernel.org, suse.cz, goodmis.org,
 efficios.com, intel.com, infradead.org, mit.edu, linux.dev, suse.de,
 redhat.com, manguebit.org, dilger.ca, suse.com, oracle.com, brown.name,
 talpey.com, samba.org, gmail.com, microsoft.com, dubeyko.com, ionkov.net,
 codewreck.org, crudebyte.com, auristor.com, themaw.net, cs.cmu.edu,
 fluxnic.net, tyhicks.com, physik.fu-berlin.de, vivo.com,
 artax.karlin.mff.cuni.cz, nod.at, paragon-software.com, fasheh.com,
 evilplan.org, linux.alibaba.com, omnibond.com, szeredi.hu, alarsen.net,
 huawei.com, wdc.com, canonical.com, paul-moore.com, namei.org, hallyn.com,
 linux.ibm.com, schaufler-ca.com, amd.com, ffwll.ch, linaro.org, google.com,
 davemloft.net, arm.com, linux.intel.com, dev.tdt.de, yaina.de, holtmann.org,
 hartkopp.net, pengutronix.de, secunet.com, gondor.apana.org.au, fomichev.me,
 iogearbox.net, vger.kernel.org, lists.linux.dev, kvack.org,
 lists.sourceforge.net, lists.samba.org, lists.infradead.org, coda.cs.cmu.edu,
 lists.orangefs.org, lists.ubuntu.com, lists.freedesktop.org, lists.linaro.or
 g]; RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLswtmdueuza7a4srcp7atxnzq)];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCPT_COUNT_GT_50(0.00)[172];
 RCVD_TLS_LAST(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Headers-End: 1vxNpZ-0003bk-Fu
Subject: Re: [f2fs-dev] [PATCH v2 014/110] proc: use PRIino format for i_ino
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
 linux-nilfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 John Fastabend <john.fastabend@gmail.com>, codalist@coda.cs.cmu.edu,
 Remi Denis-Courmont <courmisch@gmail.com>, linux-trace-kernel@vger.kernel.org,
 Olga Kornievskaia <okorniev@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon 02-03-26 15:23:58, Jeff Layton wrote:
> Convert proc i_ino format strings to use the PRIino format
> macro in preparation for the widening of i_ino via kino_t.
> 
> Update local variables and function parameters that hold i_ino
> values from unsigned long to kino_t.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/fd.c       | 2 +-
>  fs/proc/task_mmu.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 9eeccff49b2abf57d766ce17fe47070c379ed2c8..936d0258d688be5fdc384ee5c4dfbb8fa0d19dff 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -54,7 +54,7 @@ static int seq_show(struct seq_file *m, void *v)
>  	if (ret)
>  		return ret;
>  
> -	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n",
> +	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%" PRIino "u\n",
>  		   (long long)file->f_pos, f_flags,
>  		   real_mount(file->f_path.mnt)->mnt_id,
>  		   file_inode(file)->i_ino);
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e091931d7ca19d71f31699913d177eec0821ca7b..702b0f0433f91077cd0d0af4a07e9d67d9fa9a45 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -442,7 +442,7 @@ static void get_vma_name(struct vm_area_struct *vma,
>  static void show_vma_header_prefix(struct seq_file *m,
>  				   unsigned long start, unsigned long end,
>  				   vm_flags_t flags, unsigned long long pgoff,
> -				   dev_t dev, unsigned long ino)
> +				   dev_t dev, kino_t ino)
>  {
>  	seq_setwidth(m, 25 + sizeof(void *) * 6 - 1);
>  	seq_put_hex_ll(m, NULL, start, 8);
> @@ -465,7 +465,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
>  	const struct path *path;
>  	const char *name_fmt, *name;
>  	vm_flags_t flags = vma->vm_flags;
> -	unsigned long ino = 0;
> +	kino_t ino = 0;
>  	unsigned long long pgoff = 0;
>  	unsigned long start, end;
>  	dev_t dev = 0;
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
