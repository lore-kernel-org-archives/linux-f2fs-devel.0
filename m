From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: avoid unnecessary function call
Date: Wed, 5 Jul 2017 10:25:06 +0800
Message-ID: <34b33dd7-6004-8470-3e4d-983cf7c2adf9@kernel.org>
References: <22a88618.4a1.15cfb3e2aeb.Coremail.kernelpatch@126.com>
	<20170701073932.GA85052@jaegeuk-macbookpro.roam.corp.google.com>
	<53aec610.3d6a.15d040bfb68.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dSa1E-0003l6-Qc
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 02:26:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dSa1B-0004xc-7C
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 02:26:20 +0000
In-Reply-To: <53aec610.3d6a.15d040bfb68.Coremail.kernelpatch@126.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Tiezhu Yang <kernelpatch@126.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi all,

I'm not against this change, since this follows most error handling rule of
f2fs codes that caller will know whether it need to do error handling instead
of callee.

Would it be better to change as below:

---
 fs/f2fs/namei.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 66d6dd280184..175167a51970 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1086,26 +1086,26 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	/* this is broken symlink case */
 	if (unlikely(cstr.len == 0)) {
 		res = -ENOENT;
-		goto errout;
+		goto out_put;
 	}

 	if ((cstr.len + sizeof(struct fscrypt_symlink_data) - 1) > max_size) {
 		/* Symlink data on the disk is corrupted */
 		res = -EIO;
-		goto errout;
+		goto out_put;
 	}
 	res = fscrypt_fname_alloc_buffer(inode, cstr.len, &pstr);
 	if (res)
-		goto errout;
+		goto out_put;

 	res = fscrypt_fname_disk_to_usr(inode, 0, 0, &cstr, &pstr);
 	if (res)
-		goto errout;
+		goto out_free;

 	/* this is broken symlink case */
 	if (unlikely(pstr.name[0] == 0)) {
 		res = -ENOENT;
-		goto errout;
+		goto out_free;
 	}

 	paddr = pstr.name;
@@ -1116,8 +1116,9 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	put_page(cpage);
 	set_delayed_call(done, kfree_link, paddr);
 	return paddr;
-errout:
+out_free:
 	fscrypt_fname_free_buffer(&pstr);
+out_put:
 	put_page(cpage);
 	return ERR_PTR(res);
 }
-- 
2.13.0.90.g1eb437020



On 2017/7/3 0:04, Tiezhu Yang wrote:
> Hi, Jaegeuk
> 
> At 2017-07-01 15:39:32, "Jaegeuk Kim" <jaegeuk@kernel.org> wrote:
>> On 07/01, Tiezhu Yang wrote:
>>> It should call the function fscrypt_fname_free_buffer() in the exception
>>> handling only after the function fscrypt_fname_alloc_buffer() returns 0,
>>> otherwise it is unnecessary.
>>
>> Hi, fscrypt_fname_free_buffer returns if crypto_str is null. So, this flow
>> has no problem, which would be a quite conventional flow, no?
> 
> Understood, just two points of view, both are OK.
> In my opinion, I would prefer not to call the function fscrypt_fname_free_buffer since I am
> absolutely sure that its argument is NULL and it will return directly without doing anything,
> this patch is to avoid unnecessary function call.
> 
> Thanks,
> 
>>
>> Thanks,
>>
>>> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
>>> ---
>>>  fs/f2fs/namei.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>> index c31b40e..3225a82 100644
>>> --- a/fs/f2fs/namei.c
>>> +++ b/fs/f2fs/namei.c
>>> @@ -1036,12 +1036,12 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
>>>  
>>>  	res = fscrypt_fname_disk_to_usr(inode, 0, 0, &cstr, &pstr);
>>>  	if (res)
>>> -		goto errout;
>>> +		goto out;
>>>  
>>>  	/* this is broken symlink case */
>>>  	if (unlikely(pstr.name[0] == 0)) {
>>>  		res = -ENOENT;
>>> -		goto errout;
>>> +		goto out;
>>>  	}
>>>  
>>>  	paddr = pstr.name;
>>> @@ -1052,8 +1052,9 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
>>>  	put_page(cpage);
>>>  	set_delayed_call(done, kfree_link, paddr);
>>>  	return paddr;
>>> -errout:
>>> +out:
>>>  	fscrypt_fname_free_buffer(&pstr);
>>> +errout:
>>>  	put_page(cpage);
>>>  	return ERR_PTR(res);
>>>  }
>>> -- 
>>> 1.8.3.1
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
