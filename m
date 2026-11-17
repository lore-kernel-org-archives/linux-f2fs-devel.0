Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA9606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y4JiQt0O;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KYmV5JmN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U78WUyUL;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weI3kTBk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=efzoaC1/OKJkxjirV/7Anh2/j/4ewlPY/28MzbkhzLE=; b=Y4JiQt0OCpIO2H/nNaTO7cB9rI
	mZgM2oh3Awo1LnJhlk6szgQQW8spq2sO9qOIyrEz2+cDhXkazDPplZIScXOhl7CPtB0Lvf78htPuo
	VnEX7r3nymsXdsHOs2Joqz0NXvW4O+cafLUGkYcu0siJCR59SHqXbAAg7cLj3rf0C3T4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTCrW-000000003JS-4387;
	Tue, 17 Nov 2026 06:40:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhanxusheng1024@gmail.com>)
 id 1xTCrV-000000003JL-3KcN
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 06:40:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eDKHBCbv46PsJNdfpvRyzWGbD1LCk4RnEYpm63YeSeg=; b=KYmV5JmNG915IPawzO/6wo5CUg
 3Md74niD7Dx3GaFm0Vw56IJZ+D1wCmpAcE8I042aj8WX+ENiENJukJ9kNsjjbUVTorT1hHSNRJXC9
 0bJ9QIJcikQzoLF8uDU2HuQ6RZaWSmjf0R8+hw0STZYvphETBqadQ+I5mvIZG5KZ4Rps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eDKHBCbv46PsJNdfpvRyzWGbD1LCk4RnEYpm63YeSeg=; b=U78WUyULjzN+FqucHw4vpRlFLi
 i3ClU7VksW+Zx+88GTf2W8zf0tYrykx2IyYWuzPNmUV0ZNMO5xnmp+UB8+2/zj8LWN/jYu37qMuNk
 DwqiExIbFaAbnduJTZT4yN3nUuZ8hpo60QqgnRABWLnOFbhPyDegjEj1SOXWYe9PEa5U=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTCrU-0000000078m-0lW2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 06:40:13 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3b09a83d12aso4074357a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 22:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794897606; x=1795502406; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eDKHBCbv46PsJNdfpvRyzWGbD1LCk4RnEYpm63YeSeg=;
 b=weI3kTBkpfytKXXy+QR7lG+Gi/kP76P2jNNXgjRca4x/BuZkoDH0vYgFxdFExW7K1W
 xMk+y2Zf2qXR8qT6KMdO5XpJjWn1vA/wD2G/GUDfQbomNoLt/gZGIetczWqe7d4rcVHv
 hQtcAAQIzO77bsyo4XbRj7Ra3BT/uy7kdDfy4Vlke0rv/+kKxSDUrznBJ7G6SBiUgaS7
 BFaPxQY+7aCQ+LXYU1HfVXZ8dAiDbvPZwU1tHeVuaA+EhoZTUSRhuef8MIGKtZsT8yC2
 jvCkFKNJ2WOfBgXvqw8cRTJbVeR+b/F2u9RvxvQ6wVjO7jtuDwedLCyMBnnnYwoSuWZ9
 Uljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794897606; x=1795502406;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eDKHBCbv46PsJNdfpvRyzWGbD1LCk4RnEYpm63YeSeg=;
 b=dfBKEENF0oYA4T0kCuCje7NXKNpvrGx624h0Q1C6QSR/g9bxkiE37erMblD8RuStiV
 JP/1hsoilS9u3btyQgvARSWBNnSa/tehZbFYwkHnzGHZhNx/JeEBfmqqLnpokZt+GxxV
 xc5AYcm6wkwNIYtYbdEzt2HF+Mty+dz0PSNWFfyD4aR0Or+Wl/XXRk5ufQioaVg+MU+i
 aIuQ/6v+pA9TvY96jJbUnxd4BTlGJqo4mSIGZxAneuYkI1t9ZIlpxK1L2r/jzUvYycxq
 GZNt9CqgVfgxNmW4WPQOyT5BppkykDjglLwKcsqaP2UD3Jq2WO50bQeA7OBZqqxfGxRV
 a9kA==
X-Forwarded-Encrypted: i=1;
 AL+hErGcT6C/JIv6cgn9wwmiLrI9qUCT1JuezACBMswwLckhiEJvKv7IeewjV1R0QKA442zaCIExzdMx6uJUv/5EOAHU@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9MiiyPE73tIGjegcw5vwqhEOnnPMgq/73Fo/EvaTlhxFMCGlOS
 +CWPXLOhpry26O29SR0gchpoesOdNEBVdxE1D3PrlaWF43p95VYsQ8rJNYf8YnSQ
X-Gm-Gg: AZFdTZdS/ea9ZrxX8Eo1DxU/cDLZAiys8ytZTS7iNK3dUiuHBAffenUpv3V/Lo7Ebz0
 GKuUsK1wkndY7rObjNSaCYnK1/RjZr0D1i7QxSp+mwdPCz4mhwJRGLk2NsIbK3rLWWD49lDUFEU
 IjSFtxZRuwfVKDtsPx7g/wAGj6IisH9GbecLhfHgDYKUjJjrmu5OP6j05YPwR4tybAv3MVUFnK9
 zmX4q5gDQLGs7HbDMveNh9C+0cx+QAfUpIlSeElUWP4NdK0t68ijdmqJIOwzJ+Vs7agCSUXdSj/
 Y/AMZvobxp7XJFgRWvCWvLyswProBx0M3x77jd/lkKKiKDbyX5x+1EdkMCcq20Jcctwe8FYAnVW
 sqSTvh7cgGZYYqeP0l+JzyBnHhwQtxXF/9r2WOXcizqXxtbITZ6xAn6cCxY1h8TBoiht/nOKjnz
 3gn0T8XJBEjCNA0ISXDUt+Qe4MoufsgqbU12t4rPtHaVH/QtKdlI15bdgqRbcqrXPCK4M07oukh
 KPSf+u48DMCQfD7W4LWaObCg0mOcgGFyW9tA2XnojJT6rj8gv9Y5FgDbbG3tHg06P7rocz38FPw
 5S/IXKQjve+flgRtO3AeNRgjWsvWDVlC4+qV95vC4r9L4Q==
X-Received: by 2002:a17:90b:1fc4:b0:3ab:188b:c5bf with SMTP id
 98e67ed59e1d1-3b1b0b57dc8mr12548473a91.18.1794897606443; 
 Mon, 16 Nov 2026 22:40:06 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3a3f1224asm1612793a91.4.2026.11.16.22.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 22:40:05 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 17 Nov 2026 14:39:59 +0800
Message-ID: <20261117063959.2925223-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xTCrU-0000000078m-0lW2
Subject: [f2fs-dev] [PATCH v2] f2fs: fold casefolded names of F2FS_NAME_LEN
 bytes or more
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: zhanxusheng@xiaomi.com, andrealmeid@igalia.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, krisman@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RnJvbTogWmhhbiBYdXNoZW5nIDx6aGFueHVzaGVuZ0B4aWFvbWkuY29tPgoKZjJmc19pbml0X2Nh
c2Vmb2xkZWRfbmFtZSgpIGZvbGRzIGludG8gYW4gRjJGU19OQU1FX0xFTiBieXRlIGJ1ZmZlciwK
YnV0IHV0ZjhfY2FzZWZvbGQoKSBhbHNvIHdyaXRlcyBhIHRlcm1pbmF0aW5nIE5VTCwgYW5kIGNh
bm9uaWNhbApkZWNvbXBvc2l0aW9uIGNhbiBtYWtlIGEgbmFtZSB1cCB0byB0aHJlZSB0aW1lcyBs
b25nZXIuICBBIG5hbWUgdGhhdApmb2xkcyB0byBGMkZTX05BTUVfTEVOIGJ5dGVzIG9yIG1vcmUg
aXMgdGhlcmVmb3JlIG5vdCBmb2xkZWQsIGFuZCBpcwpoYXNoZWQgYW5kIGNvbXBhcmVkIGFzIGdp
dmVuLiAgSW4gYSBjYXNlZm9sZGVkIGRpcmVjdG9yeSwgY3JlYXRpbmcKJ0EnIHggMjU1IGZhaWxz
IHdpdGggRUlOVkFMIHVuZGVyIHV0Zjg6c3RyaWN0LiAgV2l0aG91dCBzdHJpY3QsIGFmdGVyCmNy
ZWF0aW5nICdBJyB4IDI1NSwgc3RhdCBvZiAnYScgeCAyNTUgcmV0dXJucyBFTk9FTlQgYW5kIGNy
ZWF0aW5nIGl0CmFkZHMgYSBzZWNvbmQgZW50cnksIGFuZCAnw4UnIHggMTI3ICgyNTQgYnl0ZXMp
IGNhbm5vdCBiZSBmb3VuZCBhcwonw6UnIHggMTI3LgoKRm9sZCBpbnRvIDMgKiBGMkZTX05BTUVf
TEVOICsgMSBieXRlcy4gIEVudHJpZXMgY3JlYXRlZCBiZWZvcmUgdGhpcwpmb3Igc3VjaCBuYW1l
cyBhcmUgaGFzaGVkIGJ5IHRoZSBuYW1lIGFzIGdpdmVuLCBzbyBzZWFyY2ggbGluZWFybHkKZm9y
IHRoZW0gYmVmb3JlIGNvbmNsdWRpbmcgdGhhdCB0aGUgbmFtZSBpcyBhYnNlbnQuCgpGaXhlczog
NDNjNzgwYmEyNjI0ICgiZjJmczogcmV3b3JrIGZpbGVuYW1lIGhhbmRsaW5nIikKU2lnbmVkLW9m
Zi1ieTogWmhhbiBYdXNoZW5nIDx6aGFueHVzaGVuZ0B4aWFvbWkuY29tPgotLS0KdjI6Ci0gZm9s
ZCBpbnRvIDMgKiBGMkZTX05BTUVfTEVOICsgMSBieXRlcywgYXMgZGVjb21wb3NpdGlvbiBjYW4g
ZXhwYW5kCiAgYSBuYW1lIHRvIHRocmVlIHRpbWVzIGl0cyBsZW5ndGggKEVyaWMpCi0gZmluZCBl
bnRyaWVzIGhhc2hlZCBieSB0aGUgbmFtZSBhcyBnaXZlbiB3aXRoIHRoZSBleGlzdGluZyBsaW5l
YXIKICBzZWFyY2ggaW5zdGVhZCBvZiBhIHNlY29uZCBoYXNoZWQgbG9va3VwLCB3aGljaCB1c2Vk
IHRoZSBoYXNoIG9mIHRoZQogIG5hbWUgYXMgdHlwZWQgYW5kIG1pc3NlZCBlbnRyaWVzIGNyZWF0
ZWQgd2l0aCBvdGhlciBjYXNlLCBjb3VsZAogIGNyZWF0ZSBhIGR1cGxpY2F0ZSB0aGF0IHNoYWRv
d2VkIHRoZW0sIGFuZCB3YXMgc2tpcHBlZCBkdXJpbmcKICByb2xsLWZvcndhcmQgcmVjb3Zlcnkg
YWZ0ZXIgY2ZfbmFtZSBpcyBmcmVlZCAoU2FzaGlrbykKLSBkb24ndCBmYWxsIGJhY2sgYWZ0ZXIg
dGhlIGhhc2hlZCBsb29rdXAgZmFpbGVkIHdpdGggYW4gZXJyb3IsIHdoaWNoCiAgdGhlIGV4aXN0
aW5nIGZhbGxiYWNrIGFsc28gZGlkIG5vdCBjaGVjayAoU2FzaGlrbykKClJGQzogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYxMTAzMDMwNzEyLjE1MTQ4MDAtMS16aGFueHVzaGVuZzEw
MjRAZ21haWwuY29tLwoKT25seSBuYW1lcyB0aGF0IGZvbGQgdG8gMjU1IGJ5dGVzIG9yIG1vcmUg
cGF5IGZvciB0aGUgbGluZWFyIHNlYXJjaCwKb24gYSBtaXNzLCB3aGljaCBpbmNsdWRlcyBldmVy
eSBjcmVhdGUgb2Ygc3VjaCBhIG5hbWUuCgpUZXN0ZWQgaW4gYSBWTSBvbiBmMmZzL2RldiA5YjEy
Mjk5YjQzN2Ugd2l0aCBsb29rdXBfbW9kZT1wZXJmICh0aGUKZGVmYXVsdCkgYW5kIGxvb2t1cF9t
b2RlPWNvbXBhdCwgYW5kIGluIGEgZGlyZWN0b3J5IHdpdGggMzAwMCBtb3JlCmVudHJpZXMgKGRl
cHRoIDUpLCBzYW1lIHJlc3VsdHMuICBFbnRyaWVzIGNyZWF0ZWQgYnkgdGhlCnVucGF0Y2hlZCBr
ZXJuZWwsIHRoZW4gbG9va2VkIHVwIGFuZCBjcmVhdGVkIGJ5IGVhY2gga2VybmVsOgoKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVucGF0Y2hlZCAgIHBhdGNoZWQKICBzdGF0
ICdhJyB4IDI1NSAgICAgICAgICAgICAgICAgICAgIEVOT0VOVCAgICAgIGZvdW5kCiAgdG91Y2gg
J2EnIHggMjU1ICAgICAgICAgICAgICAgICAgICAybmQgZW50cnkgICBubyBuZXcgZW50cnkKICAn
w4UnIHggODUgYXMgZGVjb21wb3NlZCAoMjU1QikgICAgICBFTk9FTlQgICAgICBmb3VuZAogICfD
hScgeCAxMjcgYXMgJ8OlJyB4IDEyNyAgICAgICAgICAgICBFTk9FTlQgICAgICBmb3VuZAogIHV0
Zjg6c3RyaWN0LCBjcmVhdGUgJ1MnIHggMjU1ICAgICAgRUlOVkFMICAgICAgb2sKICB1dGY4OnN0
cmljdCwgY3JlYXRlIFUrRDdBMyB4IDg1CiAgKGZvbGRzIHRvIDc2NSBieXRlcykgICAgICAgICAg
ICAgICBFSU5WQUwgICAgICBvawogIHJtICsgcmVjcmVhdGUgJ0EnIHggMjU1LCBmc3luYywKICBj
cmFzaCwgcm9sbC1mb3J3YXJkICAgICAgICAgICAgICAgIC0gICAgICAgICAgIG9uZSBlbnRyeSwg
bmV3IGRhdGEKCkVudHJpZXMgY3JlYXRlZCBieSB0aGUgcGF0Y2hlZCBrZXJuZWwgYXJlIGhhc2hl
ZCBieSB0aGUgZm9sZGVkIG5hbWUuCkFuIHVucGF0Y2hlZCBrZXJuZWwgZmluZHMgdGhlbSBvbmx5
IGJ5IHRoZWlyIGV4YWN0IG5hbWUgYW5kIG9ubHkgd2l0aApsb29rdXBfbW9kZT1jb21wYXQuICBm
c2NrLmYyZnMsIHdoaWNoIGZvbGRzIGludG8gUEFUSF9NQVgsIGNvbXB1dGVzIHRoZQpzYW1lIGhh
c2ggZm9yIHRoZW0sIGFuZCBzdGlsbCByZXdyaXRlcyB0aGUgaGFzaCBvZiB0aGUgb2xkIGVudHJp
ZXMuCkVuY3J5cHRlZCBkaXJlY3RvcmllcyBhcmUgbm90IHRlc3RlZC4KLS0tCiBmcy9mMmZzL2Rp
ci5jICAgfCAgOCArKysrKy0tLQogZnMvZjJmcy9mMmZzLmggIHwgMTMgKysrKysrKysrKysrKwog
ZnMvZjJmcy9zdXBlci5jIHwgIDIgKy0KIDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9mMmZzL2Rpci5jIGIvZnMvZjJmcy9k
aXIuYwppbmRleCA3MDg0NzMxM2NhNmEuLmUyMDljZGI1ODc1MiAxMDA2NDQKLS0tIGEvZnMvZjJm
cy9kaXIuYworKysgYi9mcy9mMmZzL2Rpci5jCkBAIC03Niw3ICs3Niw3IEBAIGludCBmMmZzX2lu
aXRfY2FzZWZvbGRlZF9uYW1lKGNvbnN0IHN0cnVjdCBpbm9kZSAqZGlyLAogCQkJcmV0dXJuIC1F
Tk9NRU07CiAKIAkJbGVuID0gdXRmOF9jYXNlZm9sZChzYi0+c19lbmNvZGluZywgZm5hbWUtPnVz
cl9mbmFtZSwKLQkJCQkgICAgYnVmLCBGMkZTX05BTUVfTEVOKTsKKwkJCQkgICAgYnVmLCBGMkZT
X0NGX05BTUVfTEVOKTsKIAkJaWYgKGxlbiA8PSAwKSB7CiAJCQlrbWVtX2NhY2hlX2ZyZWUoZjJm
c19jZl9uYW1lX3NsYWIsIGJ1Zik7CiAJCQlpZiAoc2JfaGFzX3N0cmljdF9lbmNvZGluZyhzYikp
CkBAIC04Niw2ICs4Niw3IEBAIGludCBmMmZzX2luaXRfY2FzZWZvbGRlZF9uYW1lKGNvbnN0IHN0
cnVjdCBpbm9kZSAqZGlyLAogCQl9CiAJCWZuYW1lLT5jZl9uYW1lLm5hbWUgPSBidWY7CiAJCWZu
YW1lLT5jZl9uYW1lLmxlbiA9IGxlbjsKKwkJZm5hbWUtPmNmX25hbWVfbG9uZyA9IGxlbiA+PSBG
MkZTX05BTUVfTEVOOwogCX0KIAogCXJldHVybiAwOwpAQCAtMzg5LDggKzM5MCw5IEBAIHN0cnVj
dCBmMmZzX2Rpcl9lbnRyeSAqX19mMmZzX2ZpbmRfZW50cnkoc3RydWN0IGlub2RlICpkaXIsCiAK
IG91dDoKICNpZiBJU19FTkFCTEVEKENPTkZJR19VTklDT0RFKQotCWlmIChmMmZzX3Nob3VsZF9m
YWxsYmFja190b19saW5lYXIoZGlyKSAmJgotCQlJU19DQVNFRk9MREVEKGRpcikgJiYgIWRlICYm
IHVzZV9oYXNoKSB7CisJaWYgKChmMmZzX3Nob3VsZF9mYWxsYmFja190b19saW5lYXIoZGlyKSB8
fCBmbmFtZS0+Y2ZfbmFtZV9sb25nKSAmJgorCQlJU19DQVNFRk9MREVEKGRpcikgJiYgIWRlICYm
ICFJU19FUlIoKmRlbnRyeV9ibG9jaykgJiYKKwkJdXNlX2hhc2gpIHsKIAkJdXNlX2hhc2ggPSBm
YWxzZTsKIAkJZ290byBzdGFydF9maW5kX2VudHJ5OwogCX0KZGlmZiAtLWdpdCBhL2ZzL2YyZnMv
ZjJmcy5oIGIvZnMvZjJmcy9mMmZzLmgKaW5kZXggNGZhNGQ4MDQyZjcwLi5kNGE0OGVmMjc0ZmQg
MTAwNjQ0Ci0tLSBhL2ZzL2YyZnMvZjJmcy5oCisrKyBiL2ZzL2YyZnMvZjJmcy5oCkBAIC02NjEs
OSArNjYxLDIyIEBAIHN0cnVjdCBmMmZzX2ZpbGVuYW1lIHsKIAkgKiB3ZSBmYWxsIGJhY2sgdG8g
dHJlYXRpbmcgdGhlIG5hbWUgYXMgYW4gb3BhcXVlIGJ5dGUgc2VxdWVuY2UuCiAJICovCiAJc3Ry
dWN0IHFzdHIgY2ZfbmFtZTsKKwkvKgorCSAqIFRoZSBjYXNlZm9sZGVkIG5hbWUgaXMgRjJGU19O
QU1FX0xFTiBieXRlcyBvciBsb25nZXIuICBPbGRlciBrZXJuZWxzCisJICogY291bGQgbm90IGZv
bGQgc3VjaCBuYW1lcyBhbmQgaGFzaGVkIHRoZW0gYXMgZ2l2ZW4sIHNvIGEgbG9va3VwIGhhcwor
CSAqIHRvIHNlYXJjaCBsaW5lYXJseSBiZWZvcmUgaXQgY2FuIGNvbmNsdWRlIHRoYXQgdGhlIG5h
bWUgaXMgYWJzZW50LgorCSAqIFRoaXMgc3RheXMgc2V0IGFmdGVyIGNmX25hbWUgaXMgZnJlZWQu
CisJICovCisJYm9vbCBjZl9uYW1lX2xvbmc7CiAjZW5kaWYKIH07CiAKKy8qCisgKiBDYW5vbmlj
YWwgZGVjb21wb3NpdGlvbiBjYW4gbWFrZSBhIG5hbWUgdXAgdG8gdGhyZWUgdGltZXMgbG9uZ2Vy
LCBhbmQKKyAqIHV0ZjhfY2FzZWZvbGQoKSBhbHNvIHdyaXRlcyBhIHRlcm1pbmF0aW5nIE5VTC4K
KyAqLworI2RlZmluZSBGMkZTX0NGX05BTUVfTEVOCSgzICogRjJGU19OQU1FX0xFTiArIDEpCisK
IHN0cnVjdCBmMmZzX2RlbnRyeV9wdHIgewogCXN0cnVjdCBpbm9kZSAqaW5vZGU7CiAJdm9pZCAq
Yml0bWFwOwpkaWZmIC0tZ2l0IGEvZnMvZjJmcy9zdXBlci5jIGIvZnMvZjJmcy9zdXBlci5jCmlu
ZGV4IDc4ZGJmMWU5MjI4NS4uMzNmZGMwMzdkNWNjIDEwMDY0NAotLS0gYS9mcy9mMmZzL3N1cGVy
LmMKKysrIGIvZnMvZjJmcy9zdXBlci5jCkBAIC01MDUsNyArNTA1LDcgQEAgc3RydWN0IGttZW1f
Y2FjaGUgKmYyZnNfY2ZfbmFtZV9zbGFiOwogc3RhdGljIGludCBfX2luaXQgZjJmc19jcmVhdGVf
Y2FzZWZvbGRfY2FjaGUodm9pZCkKIHsKIAlmMmZzX2NmX25hbWVfc2xhYiA9IGYyZnNfa21lbV9j
YWNoZV9jcmVhdGUoImYyZnNfY2FzZWZvbGRlZF9uYW1lIiwKLQkJCQkJCSAgIEYyRlNfTkFNRV9M
RU4pOworCQkJCQkJICAgRjJGU19DRl9OQU1FX0xFTik7CiAJcmV0dXJuIGYyZnNfY2ZfbmFtZV9z
bGFiID8gMCA6IC1FTk9NRU07CiB9CiAKCmJhc2UtY29tbWl0OiA5YjEyMjk5YjQzN2UwY2MzZWJm
NDAyZTdiMzZhODljYzY5MTUxMjM4Ci0tIAoyLjQzLjAKCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QK
TGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
