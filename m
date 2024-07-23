Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A240AC3DA63
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:33:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sWAxS-0003Y5-9I;
	Tue, 23 Jul 2024 08:33:18 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <youling.tang@linux.dev>) id 1sWAxR-0003Xz-0d
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jul 2024 08:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3VCZOZWRmGd8xL5SN+J0EY1zI5GAsbkGIgLsBKI32rY=; b=SCkEdYs0STtsBLLyZwKO2PqaJ4
 WX8yuSjcxEsnlzbcw0UJ//3qx1j0KYgXuGvxU6yE5krqxm+gVIcnObL+6VFM5Aw0O9/OyqDXlNHqE
 VAWf/McnFNuAFXfE9rRHjKJSp1I8RAdYZw9qjZe+ah0UDCIxI7hkcuZ1GfZHV5kSGwqo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3VCZOZWRmGd8xL5SN+J0EY1zI5GAsbkGIgLsBKI32rY=; b=RjtdkOreP0i7gEMS0q65NbVXVk
 Ymq/imSRLwHf7i0zECxqPlpnd33EYq5NyPsmfcElTwQXUHbdHWK0L9a8GI6CO3qYFlCo0+aZ7DEyD
 tBOk7WgsXFgtV4mp+RwiNEH6zvNdSb+GYhzu7pjnxmkiaq5pTTvwuTZrf9RvlCZ2b8CE=;
Received: from out-177.mta0.migadu.com ([91.218.175.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sWAxP-0003rW-Nj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jul 2024 08:33:16 +0000
X-Envelope-To: arnd@arndb.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1721723584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VCZOZWRmGd8xL5SN+J0EY1zI5GAsbkGIgLsBKI32rY=;
 b=cQx+gVTPFpYaKvaHYXeReUXRhKDPTWx/sb5DeYOwR8gRsNRrwJFY99FHH1UzFuoA6giSAU
 /S7ZkQOGJ63xrCh96+rIE9S1wWbRPni1uyscrvGEAXhmVxohVvd7OpcuqyO8XTXotjZH2w
 UFvUkVqKYobrZYhSNeojetonj1chNhg=
X-Envelope-To: mcgrof@kernel.org
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: hch@infradead.org
X-Envelope-To: linux-arch@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-modules@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Date: Tue, 23 Jul 2024 16:32:36 +0800
Message-Id: <20240723083239.41533-2-youling.tang@linux.dev>
In-Reply-To: <20240723083239.41533-1-youling.tang@linux.dev>
References: <20240723083239.41533-1-youling.tang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1sWAxP-0003rW-Nj
Subject: [f2fs-dev] [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
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
Cc: linux-arch@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-modules@vger.kernel.org, youling.tang@linux.dev,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Youling Tang <tangyouling@kylinos.cn>

In theory init/exit should match their sequence, thus normally they should
look like this:
-------------------------+------------------------
    init_A();            |
    init_B();            |
    init_C();            |
                         |   exit_C();
                         |   exit_B();
                         |   exit_A();

Providing module_subinit{_noexit} and module_subeixt helps macros ensure
that modules init/exit match their order, while also simplifying the code.

The three macros are defined as follows:
- module_subinit(initfn, exitfn,rollback)
- module_subinit_noexit(initfn, rollback)
- module_subexit(rollback)

`initfn` is the initialization function and `exitfn` is the corresponding
exit function.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 include/asm-generic/vmlinux.lds.h |  5 +++
 include/linux/init.h              | 62 ++++++++++++++++++++++++++++++-
 include/linux/module.h            | 22 +++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 677315e51e54..48ccac7c6448 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -927,6 +927,10 @@
 		INIT_CALLS_LEVEL(7)					\
 		__initcall_end = .;
 
+#define SUBINIT_CALL							\
+		*(.subinitcall.init)					\
+		*(.subexitcall.exit)
+
 #define CON_INITCALL							\
 	BOUNDED_SECTION_POST_LABEL(.con_initcall.init, __con_initcall, _start, _end)
 
@@ -1155,6 +1159,7 @@
 		INIT_DATA						\
 		INIT_SETUP(initsetup_align)				\
 		INIT_CALLS						\
+		SUBINIT_CALL						\
 		CON_INITCALL						\
 		INIT_RAM_FS						\
 	}
diff --git a/include/linux/init.h b/include/linux/init.h
index ee1309473bc6..e8689ff2cb6c 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -55,6 +55,9 @@
 #define __exitdata	__section(".exit.data")
 #define __exit_call	__used __section(".exitcall.exit")
 
+#define __subinit_call	__used __section(".subinitcall.init")
+#define __subexit_call	__used __section(".subexitcall.exit")
+
 /*
  * modpost check for section mismatches during the kernel build.
  * A section mismatch happens when there are references from a
@@ -115,6 +118,9 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+typedef int (*subinitcall_t)(void);
+typedef void (*subexitcall_t)(void);
+
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
 typedef int initcall_entry_t;
 
@@ -183,7 +189,61 @@ extern struct module __this_module;
 #endif
 
 #endif
-  
+
+#ifndef __ASSEMBLY__
+struct subexitcall_rollback {
+	/*
+	 * Records the address of the first sub-initialization function in the
+	 * ".subexitcall.exit" section
+	 */
+	unsigned long first_addr;
+	int ncalls;
+};
+
+static inline void __subexitcall_rollback(struct subexitcall_rollback *r)
+{
+	unsigned long addr = r->first_addr - sizeof(r->first_addr) * (r->ncalls - 1);
+
+	for (; r->ncalls--; addr += sizeof(r->first_addr)) {
+		unsigned long *tmp = (void *)addr;
+		subexitcall_t fn = (subexitcall_t)*tmp;
+		fn();
+	}
+}
+
+static inline void set_rollback_ncalls(struct subexitcall_rollback *r)
+{
+	r->ncalls++;
+}
+
+static inline void set_rollback_first_addr(struct subexitcall_rollback *rollback,
+					   unsigned long addr)
+{
+	if (!rollback->first_addr)
+		rollback->first_addr = addr;
+}
+
+#define __subinitcall_noexit(initfn, rollback)					\
+do {										\
+	static subinitcall_t __subinitcall_##initfn __subinit_call = initfn;	\
+	int _ret;								\
+	_ret = initfn();							\
+	if (_ret < 0) {								\
+		__subexitcall_rollback(rollback);				\
+		return _ret;							\
+	}									\
+} while (0)
+
+#define __subinitcall(initfn, exitfn, rollback)						\
+do {											\
+	static subexitcall_t __subexitcall_##exitfn __subexit_call = exitfn;		\
+	set_rollback_first_addr(rollback, (unsigned long)&__subexitcall_##exitfn);	\
+	__subinitcall_noexit(initfn, rollback);						\
+	set_rollback_ncalls(rollback);							\
+} while (0)
+
+#endif /* !__ASSEMBLY__ */
+
 #ifndef MODULE
 
 #ifndef __ASSEMBLY__
diff --git a/include/linux/module.h b/include/linux/module.h
index 4213d8993cd8..95f7c60dede9 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -76,6 +76,28 @@ extern struct module_attribute module_uevent;
 extern int init_module(void);
 extern void cleanup_module(void);
 
+/*
+ * module_subinit() - Called when the driver is subinitialized
+ * @initfn: The subinitialization function that is called
+ * @exitfn: Corresponding exit function
+ * @rollback: Record information when the subinitialization failed
+ *            or the driver was removed
+ *
+ * Use module_subinit_noexit() when there is only an subinitialization
+ * function but no corresponding exit function.
+ */
+#define module_subinit(initfn, exitfn, rollback)	\
+	__subinitcall(initfn, exitfn, rollback);
+
+#define module_subinit_noexit(initfn, rollback)		\
+	__subinitcall_noexit(initfn, rollback);
+
+/*
+ * module_subexit() - Called when the driver exits
+ */
+#define module_subexit(rollback)			\
+	__subexitcall_rollback(rollback);
+
 #ifndef MODULE
 /**
  * module_init() - driver initialization entry point
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
