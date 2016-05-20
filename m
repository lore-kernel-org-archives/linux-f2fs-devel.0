From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Fri, 20 May 2016 00:58:49 -0700
Message-ID: <20160520075849.GA8067@infradead.org>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
Sender: linux-kernel-owner@vger.kernel.org
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Please don't do the mistake of versioning the structure, but instead
use feature flags, similar to what extN and modern XFS file systems do.
