From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 06/10] fs crypto: add Makefile and Kconfig
Date: Tue, 1 Mar 2016 10:30:42 -0800
Message-ID: <56D5DFD2.9020008@infradead.org>
References: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
 <1456428368-41527-7-git-send-email-jaegeuk@kernel.org>
 <56D3D99B.9090907@infradead.org>
 <20160301020447.GB60850@jaegeuk.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160301020447.GB60850@jaegeuk.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/29/16 18:04, Jaegeuk Kim wrote:
> On Sun, Feb 28, 2016 at 09:39:39PM -0800, Randy Dunlap wrote:
>> On 02/25/16 11:26, Jaegeuk Kim wrote:
>>> This patch adds a facility to enable per-file encryption.
>>>
>>> Arnd fixes a missing CONFIG_BLOCK check in the original patch.
>>> "The newly added generic crypto abstraction for file systems operates
>>> on 'struct bio' objects, which do not exist when CONFIG_BLOCK is
>>> disabled:
>>>
>>> fs/crypto/crypto.c: In function 'fscrypt_zeroout_range':
>>> fs/crypto/crypto.c:308:9: error: implicit declaration of function 'bio_alloc' [-Werror=implicit-function-declaration]
>>>
>>> This adds a Kconfig dependency that prevents FS_ENCRYPTION from being
>>> enabled without BLOCK."
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/Kconfig         |  2 ++
>>>  fs/Makefile        |  1 +
>>>  fs/crypto/Kconfig  | 17 +++++++++++++++++
>>>  fs/crypto/Makefile |  2 ++
>>>  4 files changed, 22 insertions(+)
>>>  create mode 100644 fs/crypto/Kconfig
>>>  create mode 100644 fs/crypto/Makefile
>>>
>>> diff --git a/fs/Kconfig b/fs/Kconfig
>>> index 9adee0d..9d75767 100644
>>> --- a/fs/Kconfig
>>> +++ b/fs/Kconfig
>>> @@ -84,6 +84,8 @@ config MANDATORY_FILE_LOCKING
>>>  
>>>  	  To the best of my knowledge this is dead code that no one cares about.
>>>  
>>> +source "fs/crypto/Kconfig"
>>> +
>>>  source "fs/notify/Kconfig"
>>>  
>>>  source "fs/quota/Kconfig"
>>> diff --git a/fs/Makefile b/fs/Makefile
>>> index 79f5225..47571e2 100644
>>> --- a/fs/Makefile
>>> +++ b/fs/Makefile
>>> @@ -30,6 +30,7 @@ obj-$(CONFIG_EVENTFD)		+= eventfd.o
>>>  obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
>>>  obj-$(CONFIG_AIO)               += aio.o
>>>  obj-$(CONFIG_FS_DAX)		+= dax.o
>>> +obj-y				+= crypto/
>>>  obj-$(CONFIG_FILE_LOCKING)      += locks.o
>>>  obj-$(CONFIG_COMPAT)		+= compat.o compat_ioctl.o
>>>  obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
>>> diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
>>> new file mode 100644
>>> index 0000000..9bea124e
>>> --- /dev/null
>>> +++ b/fs/crypto/Kconfig
>>> @@ -0,0 +1,17 @@
>>> +config FS_ENCRYPTION
>>> +	bool "FS Encryption (Per-file encryption)"
>>> +	depends on BLOCK
>>
>> 	depends on CRYPTO
> 
> This complains recursive dependency limitations, and I checked out that below
> ENCRYPTED_KEYS in security/keys/Kconfig selects CRYPTO.

I guess that this one also needs to select CRYPTO then.

> Thanks,
> 
>> since all of the CRYPTO_xxx below also depend on CRYPTO.
>>
>>> +	select CRYPTO_AES
>>> +	select CRYPTO_CBC
>>> +	select CRYPTO_ECB
>>> +	select CRYPTO_XTS
>>> +	select CRYPTO_CTS
>>> +	select CRYPTO_CTR
>>> +	select CRYPTO_SHA256
>>> +	select KEYS
>>> +	select ENCRYPTED_KEYS
>>> +	help
>>> +	  Enable encryption of files and directories.  This
>>> +	  feature is similar to ecryptfs, but it is more memory
>>> +	  efficient since it avoids caching the encrypted and
>>> +	  decrypted pages in the page cache.
>>> diff --git a/fs/crypto/Makefile b/fs/crypto/Makefile
>>> new file mode 100644
>>> index 0000000..f9f68cd
>>> --- /dev/null
>>> +++ b/fs/crypto/Makefile
>>> @@ -0,0 +1,2 @@
>>> +obj-y += fname.o
>>> +obj-$(CONFIG_FS_ENCRYPTION)	+= crypto.o policy.o keyinfo.o
>>>
>>
>>
>> -- 
>> ~Randy


-- 
~Randy
